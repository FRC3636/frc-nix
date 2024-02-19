import argparse
import math
import mmap
import os

parser = argparse.ArgumentParser(description='Flash SD card with image')
parser.add_argument("device", help="SD card device")
parser.add_argument("--current", help="current image file to compare against")
parser.add_argument("--block-size", type=int, default=4096, help="block size")

args = parser.parse_args()
print(args)

image = open("/dev/stdin", "rb") # image is streamed
device = open(args.device, "r+b")
current = open(args.current, "r+b") if args.current else None

device_mmap = mmap.mmap(device.fileno(), device.seek(0, os.SEEK_END))
current_mmap = mmap.mmap(current.fileno(), 0) if args.current else None

print("Flashing to", args.device, "with block size", args.block_size)

image_block = bytearray(args.block_size)

skipped = 0
written = 0

pos = 0
while image.readinto(image_block) > 0:
    if image_block == current_mmap[pos:pos + len(image_block)]:
        skipped += 1
    else:
        device_mmap[pos:pos + len(image_block)] = image_block
        current_mmap[pos:pos + len(image_block)] = image_block

        written += 1
    
    pos += len(image_block)

print("Finished flashing", written, "blocks,", skipped, "skipped")

image.close()
device_mmap.close()
current_mmap.close()