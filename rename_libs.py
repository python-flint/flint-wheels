import os
import shutil

from glob import iglob

for lib in iglob(os.getcwd() + '/**/*.lib', recursive=True):
    lib_folder = os.path.dirname(lib)
    lib_name, lib_ext = os.path.splitext(os.path.basename(lib))

    if lib_name.endswith('_lib'):
        continue

    dst = os.path.join(lib_folder, lib_name + '_lib.lib')
    print('Copying {} -> {}'.format(lib, dst))
    shutil.copy(lib, dst)
