#!/usr/bin/env node
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";

const server = new Server(
  {
    name: "bpm-finder-mcp",
    version: "1.0.0",
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: "calculate_delay_times",
        description: "Calculate delay note divisions in milliseconds for a given musical BPM.",
        inputSchema: {
          type: "object",
          properties: {
            bpm: { type: "number", description: "Beats per minute (BPM) value" },
          },
          required: ["bpm"],
        },
      },
      {
        name: "calculate_reverb_predelay",
        description: "Calculate recommended reverb pre-delay settings for a given musical BPM.",
        inputSchema: {
          type: "object",
          properties: {
            bpm: { type: "number", description: "Beats per minute (BPM) value" },
          },
          required: ["bpm"],
        },
      },
      {
        name: "calculate_bpm_tap",
        description: "Calculate BPM from an array of tap timestamps in milliseconds.",
        inputSchema: {
          type: "object",
          properties: {
            timestampsMs: {
              type: "array",
              items: { type: "number" },
              description: "Array of millisecond timestamps from user tap rhythm",
            },
          },
          required: ["timestampsMs"],
        },
      },
    ],
  };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  if (name === "calculate_delay_times") {
    const bpm = Number(args?.bpm);
    if (!bpm || bpm <= 0) {
      throw new Error("Invalid BPM value");
    }
    const qMs = 60000 / bpm;
    return {
      content: [
        {
          type: "text",
          text: JSON.stringify({
            bpm,
            quarterNoteMs: Number(qMs.toFixed(2)),
            eighthNoteMs: Number((qMs / 2).toFixed(2)),
            sixteenthNoteMs: Number((qMs / 4).toFixed(2)),
            dottedEighthMs: Number((qMs * 0.75).toFixed(2)),
            tripletEighthMs: Number(((qMs * 2) / 3).toFixed(2)),
          }, null, 2),
        },
      ],
    };
  }

  if (name === "calculate_reverb_predelay") {
    const bpm = Number(args?.bpm);
    if (!bpm || bpm <= 0) {
      throw new Error("Invalid BPM value");
    }
    const sixteenthMs = 60000 / (bpm * 4);
    const eighthMs = 60000 / (bpm * 2);

    return {
      content: [
        {
          type: "text",
          text: JSON.stringify({
            bpm,
            tightPredelayMs: Number((sixteenthMs / 2).toFixed(2)),
            naturalPredelayMs: Number(sixteenthMs.toFixed(2)),
            spaciousPredelayMs: Number(eighthMs.toFixed(2)),
          }, null, 2),
        },
      ],
    };
  }

  if (name === "calculate_bpm_tap") {
    const timestamps = args?.timestampsMs;
    if (!Array.isArray(timestamps) || timestamps.length < 2) {
      return {
        content: [{ type: "text", text: JSON.stringify({ bpm: null, message: "At least 2 tap timestamps required" }) }],
      };
    }
    const intervals = [];
    for (let i = 1; i < timestamps.length; i++) {
      intervals.push(timestamps[i] - timestamps[i - 1]);
    }
    const avg = intervals.reduce((a, b) => a + b, 0) / intervals.length;
    const bpm = Math.round(60000 / avg);

    return {
      content: [
        {
          type: "text",
          text: JSON.stringify({
            bpm,
            tapCount: timestamps.length,
            averageIntervalMs: Number(avg.toFixed(2)),
          }, null, 2),
        },
      ],
    };
  }

  throw new Error(`Unknown tool: ${name}`);
});

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
}

main().catch((error) => {
  console.error("Fatal MCP Server Error:", error);
  process.exit(1);
});
