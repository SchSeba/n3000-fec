# n3000-fec


## Build

you can use the make file for build.
overwrite the needed environment variables and run

you also need to login into the `registry.redhat.io` registry and run this on a subscribed rhel8 base system

```bash
make docker-build
```

Then you can push this to your internal registry useing the following command

```bash
mane docker-push
```

In the `bindata/rpm/driver` directory you should add the OPAE OOT driver rpm, you also will need to overwrite the location of the kernel rpms from the Makefile


## Deploy

You need to label the request nodes with the following label:

```bash
oc label <node> node-role.kubernetes.io/fpga-fec=""
```

Then you can run 

```bash
make deploy
```
