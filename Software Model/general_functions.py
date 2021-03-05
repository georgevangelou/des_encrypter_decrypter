from tables import H2B, B2H

def permute(my_str, permutation_table):
    permuted = ""
    for i in range(len(permutation_table)):
        permuted += my_str[permutation_table[i]-1]  #index correction
    return permuted

def rotate_left(block,n):
    return block[n:] + block[:n]

def hex2bin(hex_str):
    bin_str = ""
    for i in range(len(hex_str)):
        bin_str += H2B[hex_str[i]]
    return bin_str

def bin2hex(bin_str):
    hex_str = ""
    for i in range(0,len(bin_str),4):
        c = bin_str[i] + bin_str[i+1] + bin_str[i+2] + bin_str[i+3]
        hex_str += B2H[c]
    return hex_str

def int2bin(myint, bits_to_represent):
    return format(myint, 'b').zfill(bits_to_represent)

def str_xor(str1, str2):
    xored_str = ""
    for i in range(len(str1)):
        if str1[i] == str2[i]:
            xored_str += "0"
        else:
            xored_str += "1"
    return xored_str

def split(block, block_size):
    splitted = []
    for i in range(0,len(block),block_size):
        splitted.append(block[i:i+block_size])
    return splitted

