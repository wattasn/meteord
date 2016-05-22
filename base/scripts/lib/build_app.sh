set -e

COPIED_APP_PATH=/copied-app
BUNDLE_DIR=/tmp/bundle-dir

# sometimes, directly copied folder cause some wierd issues
# this fixes that
cp -R /app $COPIED_APP_PATH
cd $COPIED_APP_PATH

meteor build --directory $BUNDLE_DIR --server=http://localhost:3000

cd $BUNDLE_DIR/bundle/programs/server/
npm i

mv $BUNDLE_DIR/bundle /built_app

# cleanup
rm -rf $COPIED_APP_PATH
rm -rf $BUNDLE_DIR
rm -rf ~/.meteor
rm /usr/local/bin/meteor

# install npm packages
npm install -g grunt-cli

cd /
git clone https://github.com/chriseth/browser-solidity.git
cd browser-solidity/assets/js/
cp mode-solidity.js /built_app/programs/web.browser/packages/arch_ace-editor/ace-builds/src-noconflict
