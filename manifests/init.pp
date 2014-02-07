class java::install {
	file {
		"/usr/local/bin/get-java-version":
			ensure => file,
			mode   => 0755,
			source => "puppet:///modules/java/get-java-version";
		"/usr/local/bin/set-java-version":
			ensure => file,
			mode   => 0755,
			source => "puppet:///modules/java/set-java-version";
	}
	package {
		"openjdk-7-jre":
			ensure => installed;
	}
}

class java::config {
	exec {
		"/usr/local/bin/set-java-version 7":
			unless   => "test \"$(/usr/local/bin/get-java-version)\" -eq 7";
	}
}

class java {
	Class[ 'java::install' ]
	-> Class[ 'java::config' ]
	class {
		['java::config','java::install']:
	}
}
