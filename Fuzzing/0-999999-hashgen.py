import hashlib

# Made by Sevada797

# Open the output file in write mode
with open("0_999999_hashes.txt", "w") as output_file:
    # Loop from 0 to 999999
    for i in range(1000000):
        # Convert the number to a string
        number_str = str(i)

        # Generate MD5 hash
        md5_hash = hashlib.md5()
        md5_hash.update(number_str.encode('utf-8'))
        md5_hex = md5_hash.hexdigest()

        # Generate SHA-1 hash
        sha1_hash = hashlib.sha1()
        sha1_hash.update(number_str.encode('utf-8'))
        sha1_hex = sha1_hash.hexdigest()

        # Generate SHA-224 hash
        sha224_hash = hashlib.sha224()
        sha224_hash.update(number_str.encode('utf-8'))
        sha224_hex = sha224_hash.hexdigest()

        # Generate SHA-256 hash
        sha256_hash = hashlib.sha256()
        sha256_hash.update(number_str.encode('utf-8'))
        sha256_hex = sha256_hash.hexdigest()

        # Generate SHA-384 hash
        sha384_hash = hashlib.sha384()
        sha384_hash.update(number_str.encode('utf-8'))
        sha384_hex = sha384_hash.hexdigest()

        # Generate SHA-512 hash
        sha512_hash = hashlib.sha512()
        sha512_hash.update(number_str.encode('utf-8'))
        sha512_hex = sha512_hash.hexdigest()

        # Generate SHA-3-256 hash
        sha3_256_hash = hashlib.sha3_256()
        sha3_256_hash.update(number_str.encode('utf-8'))
        sha3_256_hex = sha3_256_hash.hexdigest()

        # Generate BLAKE2b hash
        blake2b_hash = hashlib.blake2b()
        blake2b_hash.update(number_str.encode('utf-8'))
        blake2b_hex = blake2b_hash.hexdigest()

        # Write the number and its hashes to the file
        output_file.write(f"{number_str}: MD5={md5_hex}, SHA-1={sha1_hex}, SHA-224={sha224_hex}, SHA-256={sha256_hex}, SHA-384={sha384_hex}, SHA-512={sha512_hex}, SHA3-256={sha3_256_hex}, BLAKE2b={blake2b_hex}\n")

print("Hashes generated and written to 0_999999_hashes.txt")
