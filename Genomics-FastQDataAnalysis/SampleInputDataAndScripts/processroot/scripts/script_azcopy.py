#script to call to copy any file to azure blobstorage container
#following dependencies must be installed before using this scr
#apt-get update
#apt-get -y install python-pip
#apt-get -y install build-essential libssl-dev libffi-dev python-dev
#pip install azure-storage
#example call: python python_tutorial_task2.py --sourcePath "test.jpg" --targetPath "output/barcode101/test.jpg" --targetAccount "uncpoc" --targetContainer "processroot" --targetSASToken "st=2016-12-29T17%3A43%3A00Z&se=2017-12-30T17%3A43%3A00Z&sp=rwdl&sv=2015-12-11&sr=c&sig=kPxWrHFqTVZGo4w97vRBjvsTsw%2FXZonFT%2BsJn8%2B9YcM%3D"

from __future__ import print_function
import argparse
import collections
import os
import string

import azure.storage.blob as azureblob

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--sourcePath', required=True,
                        help='sourcePath')        
    parser.add_argument('--targetPath', required=True,
                        help='targetPath')    
    parser.add_argument('--targetAccount', required=True,
                        help='targetAccount')    
    parser.add_argument('--targetContainer', required=True,
                        help='targetContainer')    
    parser.add_argument('--targetSASToken', required=True,
                        help='targetSASToken')
    args = parser.parse_args()    

blob_client = azureblob.BlockBlobService(account_name=args.targetAccount, sas_token=args.targetSASToken)

blob_client.create_blob_from_path(args.targetContainer, args.targetPath, args.sourcePath)

