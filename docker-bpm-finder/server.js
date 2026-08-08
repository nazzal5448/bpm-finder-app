const http = require('http');

const PORT = process.env.PORT || 8080;

const server = http.createServer((req, res) => {
  res.setHeader('Content-Type', 'application/json');
  res.setHeader('Access-Control-Allow-Origin', '*');

  const url = new URL(req.url, `http://${req.headers.host}`);

  if (url.pathname === '/health') {
    res.writeHead(200);
    return res.end(JSON.stringify({ status: 'ok', service: 'BPM Finder App Container' }));
  }

  if (url.pathname === '/api/calculate-delay') {
    const bpm = parseFloat(url.searchParams.get('bpm')) || 120;
    const quarter = 60000 / bpm;
    res.writeHead(200);
    return res.end(JSON.stringify({
      bpm,
      quarterNoteMs: Math.round(quarter * 100) / 100,
      eighthNoteMs: Math.round((quarter / 2) * 100) / 100,
      sixteenthNoteMs: Math.round((quarter / 4) * 100) / 100,
      dottedEighthMs: Math.round((quarter * 0.75) * 100) / 100,
      tripletEighthMs: Math.round(((quarter * 2) / 3) * 100) / 100,
      website: 'https://bpmfinderapp.com'
    }));
  }

  res.writeHead(200);
  res.end(JSON.stringify({
    name: 'BPM Finder App Container Microservice',
    endpoints: ['/health', '/api/calculate-delay?bpm=120'],
    website: 'https://bpmfinderapp.com'
  }));
});

server.listen(PORT, () => {
  console.log(`BPM Finder App microservice listening on port ${PORT}`);
});
