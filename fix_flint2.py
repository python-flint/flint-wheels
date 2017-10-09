import os
import shutil

from glob import iglob


def verbose_copy(src: str, dst: str) -> str:
    print('Copying {} -> {}'.format(src, dst))
    return shutil.copy(src, dst)
    
# Fix the location of the flint headers
flint_header = next(iglob(os.getcwd() + '/**/Release/flint.h', recursive=True))
flint_include_folder = os.path.dirname(flint_header)
target_flint_include_folder = os.path.join(flint_include_folder, 'flint')

# Now move all headers in the flint include directory
# to a subfolder called "flint"
os.makedirs(target_flint_include_folder, exist_ok=True)

for header in iglob(flint_include_folder + '/*.h'):
    verbose_copy(header, target_flint_include_folder)

verbose_copy('gettimeofday.h', flint_include_folder)

# In this folder, there is a library called "lib_flint.lib"
# we need to copy it to "flint.lib" because that's what
# distutils will later expect
verbose_copy(os.path.join(flint_include_folder, 'lib_flint.lib'),
             os.path.join(flint_include_folder, 'flint.lib'))
