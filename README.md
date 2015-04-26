Project requires:

CloudApp API wrapper (this fork fixes import issues on iOS)
https://github.com/dinhviethoa/libcloudapp-objective-c
(Since there's a severe lack of documentation here, the best way to fetch said API is to use git, as it has it's own dependencies that can be fetched through "git submodule update --init --recursive")

SDWebImage.framework
https://github.com/rs/SDWebImage
(Included in project zip)

Acknowledgements built into iOS settings through use of this script
http://stackoverflow.com/questions/6428353/best-way-to-add-license-section-to-ios-settings-bundle/6453507#6453507
(Though, the python one was used, as the perl script didn't want to run on my system)