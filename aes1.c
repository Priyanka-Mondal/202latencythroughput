#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <openssl/evp.h>
#include <openssl/aes.h>
#include <unistd.h>


int main(int argc, char **argv)
{
//fork();
int in;
//for(in=1;in<5;in++)	
//{
	EVP_CIPHER_CTX encrypt;
	EVP_CIPHER_CTX decrypt;
	unsigned char *kd = "CMPE 202 cmpe 202"; int kd_length = strlen(kd);
	unsigned char *salt = "openssl throughput";
        char *plain = "Hi this is Priyanka! This is a small attempt to create a benchmark to measure processor's throughput!"; 
	int plain_length = strlen(plain)+1;
	    int aes_rounds = atoi(argv[1]);
	//	int aes_rounds = 10;
	/*if(i == 1) 
		aes_rounds = 900000000; // for 3T instructions
	else if (i==2)
		aes_rounds = 200000000; // for  3T/4 = ~750B instructions
	else if (i==2)
                aes_rounds = 60000000;  // for 3T/16 = ~200B instructions
	else if ( i==2 )
                aes_rounds = 14000000; //  for 3T/64 = ~50B instructions
	else if ( i==2 )
                aes_rounds = 4000000;  // for 3T/256 = ~12B instructions
*/        //sleep(10); 
	unsigned char key[256], iv[32];
	int ret;
	ret = EVP_BytesToKey(EVP_aes_256_cbc(), EVP_sha1(), salt, kd, kd_length, aes_rounds, key, iv);
  	if (ret != 32) 
	{
		printf("Problem with openssl AES initialization, please run again");
    		return -1;
  	}
	//printf("%d",ret);
  	EVP_CIPHER_CTX_init(&encrypt);
  	EVP_EncryptInit_ex(&encrypt, EVP_aes_256_cbc(), NULL, key, iv);
  	EVP_CIPHER_CTX_init(&decrypt);
  	EVP_DecryptInit_ex(&decrypt, EVP_aes_256_cbc(), NULL, key, iv);




  int cipher_length = plain_length + AES_BLOCK_SIZE, f_len = 0;
  unsigned char *cipher = malloc(cipher_length);
  int len;
  len = plain_length;
  EVP_EncryptInit_ex(&encrypt, NULL, NULL, NULL, NULL);
  EVP_EncryptUpdate(&encrypt, cipher, &cipher_length, plain, len);
  EVP_EncryptFinal_ex(&encrypt, cipher+cipher_length, &f_len);
	 len= cipher_length + f_len; 
//printf("%s",cipher); 



  int pt_len = len ;
  f_len = 0;
  unsigned char *plaintext = malloc(pt_len );;
int olen = plain_length;
  EVP_DecryptInit_ex(&decrypt, NULL, NULL, NULL, NULL);
  EVP_DecryptUpdate(&decrypt, plaintext, &pt_len, cipher,len);
  EVP_DecryptFinal_ex(&decrypt, plaintext+pt_len, &f_len);

  len = pt_len + f_len;
//printf("\n%s\n",plaintext);
free(cipher);
    free(plaintext);

//  EVP_CIPHER_CTX_cleanup(&encrypt);
//  EVP_CIPHER_CTX_cleanup(&decrypt);
  return 0;
//}
}



