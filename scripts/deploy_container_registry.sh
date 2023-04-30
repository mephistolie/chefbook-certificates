dir=$(basename "$(pwd)")
if [ "$dir" == "scripts" ]; then
  cd ..
fi

cd chart || exit

# Configuration

app_name=chefbook-certificates

read -rp 'Enter version: ' version

# Helm Chart

repositoryUrl=oci://$HELM_REGISTRY
chartArchive="$app_name-$version.tgz"

helm dependency update
helm package . --version "$version"
helm push "$chartArchive" "$repositoryUrl"

rm "$chartArchive"
