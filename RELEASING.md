# Releasing

This document describes how to publish a new version to npm.

## Prerequisites (One-Time Setup)

Configure **Trusted Publishing** on npm (no secrets needed):

1. Go to [npmjs.com/package/@dsiu/rescript-mocha/access](https://www.npmjs.com/package/@dsiu/rescript-mocha/access)
2. Scroll to **Publishing access** → **Add trusted publisher**
3. Select **GitHub Actions**
4. Fill in:
   - **Repository owner**: `dsiu`
   - **Repository name**: `rescript-mocha` (or your actual repo name)
   - **Workflow filename**: `publish.yml`
   - **Environment**: (leave blank)
5. Click **Add trusted publisher**

> **Note**: For a new package that hasn't been published yet, you'll need to publish manually once first, then configure trusted publishing.

## Release Steps

### 1. Prepare the release

```bash
# Ensure you're on main branch with latest changes
git checkout main
git pull origin main

# Run tests
yarn test
```

### 2. Update version and changelog

Edit `package.json` and bump the version:
```json
"version": "0.12.0"
```

Edit `changelog.md` and document changes under the new version.

### 3. Commit the version bump

```bash
git add package.json changelog.md
git commit -m "chore: bump version to 0.12.0"
git push origin main
```

### 4. Create tag and release

```bash
# Create and push the tag
git tag v0.12.0
git push origin v0.12.0

# Create GitHub release (triggers auto-publish)
gh release create v0.12.0 --title "v0.12.0" --notes "Brief description of changes"
```

Or use `--generate-notes` to auto-generate release notes from commits:
```bash
gh release create v0.12.0 --title "v0.12.0" --generate-notes
```

### 5. Verify

- Check GitHub Actions: repo → Actions tab → "Publish to npm" workflow
- Check npm: `npm view @dsiu/rescript-mocha`

## First-Time Publishing

For a brand new package, you must publish manually once before trusted publishing works:

```bash
yarn test
npm publish --access public
```

Then configure trusted publishing as described in Prerequisites.

## Manual Publishing (if needed)

If GitHub Actions fails or you need to publish manually:

```bash
yarn test
npm publish --access public
```
