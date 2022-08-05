## discord-bad-domains

This repo is used for automatically keeping track of changes in
[Discord's bad-domains list](https://cdn.discordapp.com/bad-domains/hashes.json),
as well as the [updated one](https://cdn.discordapp.com/bad-domains/updated_hashes.json),
which clients use to warn about deceptive sites/links.

Changes are pulled in every hour, occasionally I'll run hashcat on the hash list to get an idea on what sites it contains,
just out of curiosity (see [hostnames.txt](./hostnames.txt)).

*Note: This is not affiliated with Discord in any way, and primarily serves as a historical mirror.*
