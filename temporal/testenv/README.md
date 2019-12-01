# Testenv

This is a testenv for the Temporal Kubernetes Stack

## Usage

In the testenv folder run the init script. 

``sh init.sh``

The terminal should output this: 

``````
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP    61m
postgres     ClusterIP   10.103.116.186   <none>        5432/TCP   0s
``````

The postgres CLUSTER-IP is the db address we point to in the config.json file. A template file can be found here [testenv/config.json](https://github.com/RTradeLtd/testenv/blob/master/config.json)

### Edit config.json

In the config.json change the url to the CLUSTER-IP of the postgres service

``````
"database": {
		"name": "temporal",
		"url": "CLUSTER-IP",
		"port": "5432",
		"username": "postgres",
		"password": "password123"
	},
``````

*Note: You will need to host your custom config.json remotely for now. This will change in the future.*

### Edit testenv.yaml

In the test-env.yaml file search for the init container named config on line 29. 

``````
        - name: config
          image: busybox
          command: 
          - wget
          - "-O"
          - "/temporal/config.json"
          - https://raw.githubusercontent.com/AIDXNZ/KubeIPFS/master/config.json
          
``````
Change the https://raw.githubusercontent.com/AIDXNZ/KubeIPFS/master/config.json to your remote url containing custom config.json file


## Deploy Temporal 

Once everything is configured and saved, in your terminal run:

``sh run.sh``

TODO