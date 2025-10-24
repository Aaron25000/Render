rm -rf build

# Make .love package
mkdir -p build
cd src
zip -9 -r ../build/render.love .

# Create render app (macOS)
cd ../assets
cp -R love.app ../build/Render.app

# Inject .love package into Render.app
cd ../build
cp render.love Render.app/Contents/Resources
rm render.love

# Run app
open Render.app