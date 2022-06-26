
def mapSeverity: {"1":"info","2":"info","3":"minor","4":"minor","5":"major","6":"major","7":"critical","8": "critical","9":"blocker"};

[ 
	.files | keys[] as $file | .[$file] | .messages | .[] as $msg | {
	    description: $msg.message,
        severity: mapSeverity[$msg.severity|tostring],
        location: {
            path: $file,
            lines: {
                begin: $msg.line,
                end: $msg.line
            }
        },
        fingerprint: ("\($file):\($msg.line):\($msg.source)")
    }
]
