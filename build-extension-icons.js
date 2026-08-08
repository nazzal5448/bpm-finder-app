const fs = require('fs');
const path = require('path');

const faviconPath = path.join(__dirname, '..', 'public', 'favicon.png');
const extDirs = ['chrome-extension', 'firefox-extension', 'edge-extension', 'browser-extension'];

extDirs.forEach(dir => {
  const iconsDir = path.join(__dirname, dir, 'icons');
  if (!fs.existsSync(iconsDir)) {
    fs.mkdirSync(iconsDir, { recursive: true });
  }

  fs.copyFileSync(faviconPath, path.join(iconsDir, 'icon16.png'));
  fs.copyFileSync(faviconPath, path.join(iconsDir, 'icon48.png'));
  fs.copyFileSync(faviconPath, path.join(iconsDir, 'icon128.png'));
  console.log(`Copied icons to ${dir}/icons/`);
});
