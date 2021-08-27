rompath=$(pwd)
vendor_path="vendor/extra"

function apply-waydroid-patches
{
	${vendor_path}/waydroid-patches/apply-patches.sh
}

function waydroid-generate-manifest
{
    ${vendor_path}/manifest_scripts/generate-manifest.sh
}
