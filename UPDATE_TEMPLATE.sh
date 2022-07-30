
TEMP_DIR="UPDATE_STATE_LOCK_X1"

echo "Updating using '${TEMP_DIR}' as relative storage."
echo "Cloning the 'meta' template to the relative storage."
git clone https://github.com/amethyst-studio/meta "${TEMP_DIR}"

echo "Pulling the files which can be updated."
cp -r "./${TEMP_DIR}/.github" "./"
cp -r "./${TEMP_DIR}/CODE_OF_CONDUCT.md" "./CODE_OF_CONDUCT.md"
cp -r "./${TEMP_DIR}/CONTRIBUTING.md" "./CONTRIBUTING.md"
cp -r "./${TEMP_DIR}/SECURITY.md" "./SECURITY.md"
cp -r "./${TEMP_DIR}/SUPPORT.md" "./SUPPORT.md"
cp -r "./${TEMP_DIR}/UPDATE_TEMPLATE.sh" "./UPDATE_TEMPLATE.sh"
cp -r "./${TEMP_DIR}/.editorconfig" "./.editorconfig"
cp -r "./${TEMP_DIR}/.gitattributes" "./.gitattributes"

if ! [[ "$PWD" =~ "meta" ]]; then
  sed -i "s/random/$RANDOM-$RANDOM-$RANDOM-$RANDOM/g" .github/settings.yml
  sed -i "s/vr-stage: .*//g" .github/settings.yml
else
  sed -i "s/vr-stage: .*/vr-stage: $RANDOM-$RANDOM-$RANDOM-$RANDOM/g" .github/settings.yml
fi

# Remove the UPDATE_STATE_LOCK_X1 dir.
rm -rf "./${TEMP_DIR}/"

# Commit the changes.
git reset
git add CODE_OF_CONDUCT.md
git add CONTRIBUTING.md
git add SECURITY.md
git add SUPPORT.md
git add UPDATE_TEMPLATE.sh
git add .github
git add .editorconfig
git add .gitattributes
git commit -m 'chore(meta): update cross-organization meta documents'

# Notice.
echo 'Done! Please push these changed when finished.'
