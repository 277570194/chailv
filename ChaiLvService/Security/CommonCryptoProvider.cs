using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Security.Cryptography;
using System.IO;
namespace ChaiLvService.Security
{
    /// <summary>
    /// CryptoProvider utility class
    /// </summary>
    public static class CommonCryptoProvider
    {
        private static String _ContainerName = ConfigurationManager.AppSettings["CryptoContainerName"];

        #region //Encrypt and Decsrypt methods
        /// <summary>
        /// Encrypt method
        /// </summary>
        /// <param name="encryptKey">Encrypt key</param>
        /// <param name="encryptString">Input string</param>
        /// <returns>Encrypted string</returns>
        public static String Encrypt(String encryptKey, String encryptString)
        {
            if (string.IsNullOrEmpty(encryptString))
                return string.Empty;

            String encryptedString = String.Empty;

            try
            {
                SHA1Managed objSHA1Managed = new SHA1Managed();
                Byte[] keyBytes = objSHA1Managed.ComputeHash(Encoding.Default.GetBytes(ToEncryptKey(encryptKey)));
                Byte[] key = new Byte[16];
                Array.Copy(keyBytes, key, Math.Min(16, keyBytes.Length));
                Byte[] IV = { 0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF };

                RC2CryptoServiceProvider objRC2CryptoServiceProvider = new RC2CryptoServiceProvider();
                ICryptoTransform encryptor = objRC2CryptoServiceProvider.CreateEncryptor(key, IV);

                MemoryStream msEncrypt = new MemoryStream();
                CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write);

                byte[] toEncrypt = Encoding.Default.GetBytes(encryptString);
                csEncrypt.Write(toEncrypt, 0, toEncrypt.Length);
                csEncrypt.FlushFinalBlock();

                byte[] encrypted = msEncrypt.ToArray();
                encryptedString = ToHex16String(Convert.ToBase64String(encrypted));

            }
            catch (Exception e)
            {
                throw e;
            }

            return encryptedString;
        }

        /// <summary>
        /// Encrypt method
        /// </summary>
        /// <param name="inputString">Input string for encryption or decryption</param>
        /// <returns>Encrypted or decrypted's string</returns>
        public static String Encrypt(String inputString)
        {
            return Encrypt(Constants.AspEncryptDefaultKey, inputString);
        }

        /// <summary>
        /// Dencrypt method
        /// </summary>
        /// <param name="encryptKey">Encrypt key</param>
        /// <param name="dencrptString">Input string</param>
        /// <returns>Dencrpted string</returns>
        public static String Decrypt(String encryptKey, String dencrptString)
        {
            if (string.IsNullOrEmpty(dencrptString))
                return string.Empty;

            String returnString = String.Empty;

            try
            {
                dencrptString = FromHex16String(dencrptString);

                SHA1Managed objSHA1Managed = new SHA1Managed();
                Byte[] keyBytes = objSHA1Managed.ComputeHash(Encoding.Default.GetBytes(ToEncryptKey(encryptKey)));
                Byte[] key = new Byte[16];
                Array.Copy(keyBytes, key, Math.Min(16, keyBytes.Length));
                Byte[] IV = { 0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF };

                RC2CryptoServiceProvider objRC2CryptoServiceProvider = new RC2CryptoServiceProvider();
                ICryptoTransform decryptor = objRC2CryptoServiceProvider.CreateDecryptor(key, IV);

                MemoryStream msDecrypt = new MemoryStream(Convert.FromBase64String(dencrptString));
                CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read);

                StringBuilder dencrptedString = new StringBuilder();

                int ind = 0;
                do
                {
                    ind = csDecrypt.ReadByte();

                    if (ind != -1)
                        dencrptedString.Append((char)ind);

                } while (ind != -1);

                returnString = dencrptedString.ToString();
            }
            catch (Exception e)
            {
                throw e;
            }

            return returnString;
        }

        /// <summary>
        /// Dencrypt method
        /// </summary>
        /// <param name="inputString">Input string for encryption or decryption</param>
        /// <returns>Encrypted or decrypted's string</returns>
        public static String Decrypt(String inputString)
        {
            return Decrypt(Constants.AspEncryptDefaultKey, inputString);
        }
        private static String ToEncryptKey(string encryptKey)
        {
            return _ContainerName + Constants.AspEncryptContainerName + encryptKey;
        }
        #endregion
        /// <summary>
        /// Convert from Hex16 string
        /// </summary>
        /// <param name="inputString">Input string</param>
        /// <returns>Normal string</returns>
        public static String FromHex16String(String inputString)
        {
            if (string.IsNullOrEmpty(inputString))
                return String.Empty;

            Byte[] inputs = new Byte[inputString.Length / 2];

            for (Int32 i = 0; i < inputs.Length; i++)
            {
                inputs[i] = Byte.Parse(inputString.Substring(i * 2, 2),
                     System.Globalization.NumberStyles.HexNumber);
            }

            return Encoding.Default.GetString(inputs);
        }
        /// <summary>
        /// Convert to Hex16 string
        /// </summary>
        /// <param name="inputString">Input string</param>
        /// <returns>Hex16 string</returns>
        public static String ToHex16String(this String inputString)
        {
            if (string.IsNullOrEmpty(inputString))
                return String.Empty;

            Byte[] inputs = Encoding.Default.GetBytes(inputString);

            StringBuilder outputString = new StringBuilder();

            foreach (Byte b in inputs)
                outputString.Append(b.ToString("X2"));

            return outputString.ToString();
        }
    }
}