"""Validation shared by host application builds."""
import hashlib


def module_info(path):
    data = path.read_bytes()
    if len(data) < 16 or data[:2] != b'\x87\xcd':
        raise ValueError('Not an OS-9 module')
    size = int.from_bytes(data[2:4], 'big')
    if size != len(data) or data[6] != 0x11:
        raise ValueError('Invalid module length or program type')
    parity = 0
    for byte in data[:9]:
        parity ^= byte
    if parity != 255:
        raise ValueError('Invalid module header parity')
    crc = 0xffffff
    for byte in data:
        crc ^= byte << 16
        for _ in range(8):
            crc <<= 1
            if crc & 0x1000000:
                crc ^= 0x800063
            crc &= 0xffffff
    if crc != 0x800fe3:
        raise ValueError('Invalid module CRC')
    return dict(module_bytes=size, data_bytes=int.from_bytes(data[11:13], 'big'),
                module_sha256=hashlib.sha256(data).hexdigest(), crc_valid=True)
