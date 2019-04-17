#!/usr/bin/env bash
# Replace a string wherever found in the contents of a given zip file.

INPUT_ZIP=$1
SOURCE_STR=$2
TARGET_STR=$3
shift; shift; shift;

if [[ ! "$INPUT_ZIP" || ! -f "$INPUT_ZIP" || ! "$SOURCE_STR" || ! "$TARGET_STR" || $# -ne 0 ]]; then
    >&2 echo "usage: zip-tr.sh INPUT_ZIP SOURCE_STR TARGET_STR"
    exit 2
fi;

# Create a temporary directory and ensure cleanup.
# See https://stackoverflow.com/a/34676160/410889

# the temp directory used, within $DIR
WORK_DIR=`mktemp -d`

# check if tmp dir was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  >&2 echo "Could not create temp dir"
  exit 1
fi

# deletes the temp directory
function cleanup {
  #rm -rf "$WORK_DIR"
  >&2 echo "Deleted temp working directory $WORK_DIR"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

unzip -qq "$INPUT_ZIP" -d "${WORK_DIR}"
find "${WORK_DIR}" -type f -print0 | xargs -0 sed -i -e "s/${SOURCE_STR//\//\\/}/${TARGET_STR//\//\\/}/g"
cd "${WORK_DIR}"
zip -r - .
