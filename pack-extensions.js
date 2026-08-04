const fs = require('fs');
const path = require('path');
const zlib = require('zlib');

function zipDir(srcDir, zipFilePath) {
  // Simple zip implementation using powershell Compress-Archive or node
  const { execSync } = require('child_process');
  try {
    if (fs.existsSync(zipFilePath)) fs.unlinkSync(zipFilePath);
    execSync(`powershell -Command "Compress-Archive -Path '${srcDir}/*' -DestinationPath '${zipFilePath}' -Force"`);
    console.log(`Created zip: ${zipFilePath}`);
  } catch (err) {
    console.error(`Failed to zip ${srcDir}:`, err.message);
  }
}

const packagesDir = __dirname;
zipDir(path.join(packagesDir, 'chrome-extension'), path.join(packagesDir, 'bpm-finder-chrome-extension.zip'));
zipDir(path.join(packagesDir, 'firefox-extension'), path.join(packagesDir, 'bpm-finder-firefox-extension.zip'));
zipDir(path.join(packagesDir, 'edge-extension'), path.join(packagesDir, 'bpm-finder-edge-extension.zip'));
