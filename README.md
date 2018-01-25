# speedtest.php
Speedtest.net mini/legacy-http light server. Works with [speedtest-cli](https://github.com/sivel/speedtest-cli)

In mid-2017, speedtest.net (Ookla) decided to shut down their speedtest mini project. 

This repo is an attempt at creating our own speedtest-mini server, and use [speedtest-cli](https://github.com/sivel/speedtest-cli) with it.

## Usage

### Server:
```
docker run -p <port>:80 ipburger/speedtest
```

### Client:
```
./speedtest.py --mini http://<server_ip>:<port>/speedtest/upload.php
```

Console o/p on client:
```
Retrieving speedtest.net configuration...
Testing from OVH Hosting (<client_ip>)...
Hosted by Speedtest Mini (<server_ip>:<port>) [0.00 km]: 1.44 ms
Testing download speed................................................................................
Download: 535.22 Mbit/s
Testing upload speed................................................................................................
Upload: 176.43 Mbit/s
```

## Note on [`speedtest-cli`](https://github.com/sivel/speedtest-cli)

It is one of the most popular speedtest tools out there. Although, it's functionality with *mini* servers was somewhat broken. For convinience, a patched version is included in this repo.

## TBD
- A functioning GUI - can be something like https://github.com/adolfintel/speedtest
