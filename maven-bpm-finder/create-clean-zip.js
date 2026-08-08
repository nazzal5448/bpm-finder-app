const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('🔨 Packaging standard Maven Central zip using Node.js...');

const flatDir = path.join(__dirname, 'flat_bundle');
const zipPath = path.join(__dirname, 'bpm-finder-app-1.0.0-sonatype-bundle.zip');

if (fs.existsSync(zipPath)) {
  fs.unlinkSync(zipPath);
}

// Check if 7z or tar is available, or use PowerShell with standard ZipArchive
try {
  execSync(`tar -a -c -f "${zipPath}" -C "${flatDir}" bpm-finder-app-1.0.0.pom bpm-finder-app-1.0.0.jar bpm-finder-app-1.0.0-sources.jar bpm-finder-app-1.0.0-javadoc.jar`, { stdio: 'inherit' });
  console.log('✅ Tar-based ZIP created successfully!');
} catch (e) {
  console.log('Falling back to python zipfile module...');
  execSync(`python3 -c "import zipfile, os; z = zipfile.ZipFile('${zipPath.replace(/\\/g, '/')}', 'w', zipfile.ZIP_DEFLATED); [z.write(os.path.join('${flatDir.replace(/\\/g, '/')}', f), f) for f in os.listdir('${flatDir.replace(/\\/g, '/')}')]; z.close()"`, { stdio: 'inherit' });
  console.log('✅ Python-based ZIP created successfully!');
}
