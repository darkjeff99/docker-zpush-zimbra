# ActiveSync for Zimbra with Z-push

## Get started

It's very simple, first, get it :

```bash
docker pull darkjeff/zpush-zimbra
```

And run it :

```bash
docker run -d \
	-p 80:80 \
	-e ZIMBRA_URL=yourzimbraurl.tld \
	-e ZPUSH_URL=yourpublicurlforsyn.tld \
	--name zpush
	docker pull darkjeff/zpush-zimbra
```

## Configuration

You can tune the configuration with environment variable:

| Parameter | Description |
| :-------- | :---------- |
| *ZPUSH_URL* | The url (whitout https://) of your zimbra. The container have to reach this address. |
| *ZPUSH_URL_IN_HTTP* | If your zimbra is not listenning in https set `true`.*Deflaut*: https |
| *ZIMBRA_URL* | The public url of your sync service (whitout https://) |
| *ZIMBRA_URL_IN_HTTP* | If your zimbra is not listenning in https set `true`. *Deflaut*: https |
| *TIMEZONE* | [PHP timezone] (http://php.net/manual/en/timezones.php). *Deflaut*: 'Europe/London' |
