#!/bin/bash

set -o errexit
set -o nounset

wordcount --input_file {INPUT_FILE} --output_file ${OUTPUT_FILE} --rank ${RANK}
