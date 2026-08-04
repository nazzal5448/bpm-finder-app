const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const { execSync } = require('child_process');

const workDir = __dirname;
const dataTar = path.join(workDir, 'data.tar');
const dataTarGz = path.join(workDir, 'data.tar.gz');
const metadataTxt = path.join(workDir, 'metadata');
const metadataGz = path.join(workDir, 'metadata.gz');
const gemFile = path.join(workDir, 'bpm-finder-app-1.0.0.gem');

// 1. Create data.tar.gz containing lib/bpm_finder_app.rb & README.md
try {
  execSync(`tar -cvf data.tar lib README.md`, { cwd: workDir });
  const dataBuf = fs.readFileSync(dataTar);
  const gzData = zlib.gzipSync(dataBuf);
  fs.writeFileSync(dataTarGz, gzData);
  fs.unlinkSync(dataTar);
} catch (err) {
  console.error("Tar data error:", err);
}

// 2. Create metadata.gz containing YAML specification
const metadataContent = `--- !ruby/object:Gem::Specification
name: bpm-finder-app
version: !ruby/object:Gem::Version
  version: 1.0.0
platform: ruby
authors:
- John Goldberg
email:
- support@bpmfinderapp.com
homepage: https://bpmfinderapp.com
summary: Ruby gem for audio tempo calculation, Tap BPM analysis, and delay/reverb formulas.
description: High-precision Ruby library for audio tempo detection, Tap BPM tap counting, delay note divisions, and reverb pre-delay formulas. Powered by the BPM Finder App.
license: MIT
files:
- lib/bpm_finder_app.rb
- README.md
rubygems_version: 3.3.10
specification_version: 4
`;

fs.writeFileSync(metadataTxt, metadataContent);
const metaBuf = fs.readFileSync(metadataTxt);
const gzMeta = zlib.gzipSync(metaBuf);
fs.writeFileSync(metadataGz, gzMeta);
fs.unlinkSync(metadataTxt);

// 3. Create final bpm-finder-app-1.0.0.gem archive containing metadata.gz and data.tar.gz
try {
  execSync(`tar -cvf bpm-finder-app-1.0.0.gem metadata.gz data.tar.gz`, { cwd: workDir });
  fs.unlinkSync(metadataGz);
  fs.unlinkSync(dataTarGz);
  console.log("Successfully created bpm-finder-app-1.0.0.gem");
} catch (err) {
  console.error("Gem tar error:", err);
}
