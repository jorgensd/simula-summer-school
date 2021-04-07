#!/bin/bash
set -exuo pipefail

mkdir _build
cd _build

export OPENCARP_DIR=$PREFIX
cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DDLOPEN=ON \
    -DCMAKE_BUILD_TYPE=Release \
    ..

make VERBOSE=1 -j${CPU_COUNT:-1}
# cmake --install by default default installs duplicate petsc that doesn't work (?!)
for component in core tool; do
    cmake --install . --component $component
done

bench
