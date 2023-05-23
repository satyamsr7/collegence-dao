shortAddress(String? address, {int i = 6}) {
  if (address == null) return '0x0000...0000';
  return '${address.substring(0, i)}...${address.substring(address.length - 6)}';
}
