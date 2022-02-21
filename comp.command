cd Programming/
ls
nasm -f bin -o bin/bootSector.bin asm/bootSector.asm
nasm -f bin -o bin/mainScreen.bin asm/mainScreen.asm
dd if=/dev/zero of=temp/floppy.img bs=512 count=2880
dd if=bin/bootSector.bin of=temp/floppy.img seek=0 count=1 conv=notrunc
dd if=bin/mainScreen.bin of=temp/floppy.img seek=10 conv=notrunc

mkisofs -V 'quayOS' -input-charset iso8859-1 -o builds/quayOS.iso -b floppy.img temp/
