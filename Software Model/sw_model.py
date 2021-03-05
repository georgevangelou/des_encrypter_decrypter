from tables import *
import general_functions as gf

DEBUG = True




KEY = "EE4312182736ACDE"
#KEY = "AABB09182736CCDD"
#KEY = "8000000000000000"
#KEY = "0000000000000000"

TEXT = "FF3216CE6CD325A0"
#TEXT = "123456ABCD132536"
#TEXT = "0000000000000000"


#key generation
def keygen(hex_key, stages=16):
    bin_key = gf.hex2bin(hex_key)
    keys = []
    bin_key = gf.permute(bin_key, PC1)
    if DEBUG: print("~~~  KEY GENERATION  ~~~")
    if DEBUG: print("Input key            is: {} === {}".format( gf.hex2bin(hex_key), hex_key ))
    if DEBUG: print("Input key permutated is: {} === {}".format( bin_key, gf.bin2hex(bin_key)))
    left = bin_key[:28]
    right = bin_key[28:]
    for i in range(stages):
        #Shifting
        n = SHIFT_TABLE[i]
        left = gf.rotate_left(left, n)
        right = gf.rotate_left(right, n)

        #Combining
        combined = left + right

        #KeyGen
        keys.append(gf.permute(combined, PC2))

    return keys

#cipher generation
def encrypt(hex_text, bin_keys, stages=16):
    bin_text = gf.hex2bin(hex_text)

    #Initial Permutation
    bin_text = gf.permute(bin_text, IP)
    #print("Input initial permutation: {}".format(gf.bin2hex(bin_text)))

    left = bin_text[:32]
    right = bin_text[32:]

    if DEBUG: print("~~~  CIPHER GENERATION  ~~~")
    for i in range(stages):
        #Expansion D-box
        right_expanded = gf.permute(right, E)

        #XOR right_expanded and key
        right_xored = gf.str_xor(right_expanded, bin_keys[i])

        #S-boxes
        right_s_boxed = s_boxes(right_xored)

        #Stright D-box
        right_d_boxed = gf.permute(right_s_boxed, P)

        #new left and right values
        prev_left = left
        left = right
        right = gf.str_xor(prev_left,right_d_boxed)
        
        #swap if last
        if i==15:
            left,right = right,left
        
        if DEBUG: print("Cipher {} is: {}  {}".format(i+1, gf.bin2hex(left), gf.bin2hex(right)))

    #Combine blocks
    combined = left + right
    
    #Final Permutation
    cipher = gf.permute(combined, IP_inv)

    return gf.bin2hex(cipher)


def s_boxes(block):
    n = len(S)
    block_size = int(len(block)/n)
    #prepare block for S-boxes
    blocks = gf.split(block, block_size=block_size)
    
    output = ""
    for i in range(n):
        #row is determined by first and last bit
        row = blocks[i][0] + blocks[i][-1]
        #column is determined by the remaining bitss
        col = blocks[i][1:-1]

        #convert to int
        row = int(row,2)
        col = int(col,2)

        #find output
        int_output = S[i][row][col]

        #convert to bin fixed to 4 bits
        bin_output = gf.int2bin(int_output,4)

        #concatenate
        output += bin_output
    return output

print("\n\n\n")
keys = keygen(KEY)
for i in range(len(keys)):
    if DEBUG: print("Key {} is: {}   ===    {}".format(i+1, keys[i], gf.bin2hex(keys[i])))
cipher = encrypt(TEXT, keys)

print("\n\nPlain  text is: {}".format(TEXT))
print("Key         is: {}".format(KEY))
print("Cipher text is: {}".format(cipher))

