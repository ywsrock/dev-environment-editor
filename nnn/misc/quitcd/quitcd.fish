{"payload":{"allShortcutsEnabled":false,"fileTree":{"misc/quitcd":{"items":[{"name":"quitcd.bash_sh_zsh","path":"misc/quitcd/quitcd.bash_sh_zsh","contentType":"file"},{"name":"quitcd.csh","path":"misc/quitcd/quitcd.csh","contentType":"file"},{"name":"quitcd.elv","path":"misc/quitcd/quitcd.elv","contentType":"file"},{"name":"quitcd.fish","path":"misc/quitcd/quitcd.fish","contentType":"file"},{"name":"quitcd.nu","path":"misc/quitcd/quitcd.nu","contentType":"file"}],"totalCount":5},"misc":{"items":[{"name":"auto-completion","path":"misc/auto-completion","contentType":"directory"},{"name":"desktop","path":"misc/desktop","contentType":"directory"},{"name":"haiku","path":"misc/haiku","contentType":"directory"},{"name":"logo","path":"misc/logo","contentType":"directory"},{"name":"macos-legacy","path":"misc/macos-legacy","contentType":"directory"},{"name":"musl","path":"misc/musl","contentType":"directory"},{"name":"natool","path":"misc/natool","contentType":"directory"},{"name":"packagecore","path":"misc/packagecore","contentType":"directory"},{"name":"quitcd","path":"misc/quitcd","contentType":"directory"},{"name":"test","path":"misc/test","contentType":"directory"},{"name":"CONTRIBUTING.md","path":"misc/CONTRIBUTING.md","contentType":"file"}],"totalCount":11},"":{"items":[{"name":".circleci","path":".circleci","contentType":"directory"},{"name":".github","path":".github","contentType":"directory"},{"name":"misc","path":"misc","contentType":"directory"},{"name":"patches","path":"patches","contentType":"directory"},{"name":"plugins","path":"plugins","contentType":"directory"},{"name":"src","path":"src","contentType":"directory"},{"name":".gitignore","path":".gitignore","contentType":"file"},{"name":"CHANGELOG","path":"CHANGELOG","contentType":"file"},{"name":"LICENSE","path":"LICENSE","contentType":"file"},{"name":"Makefile","path":"Makefile","contentType":"file"},{"name":"README.md","path":"README.md","contentType":"file"},{"name":"nnn.1","path":"nnn.1","contentType":"file"}],"totalCount":12}},"fileTreeProcessingTime":10.730856000000001,"foldersToFetch":[],"reducedMotionEnabled":null,"repo":{"id":66150122,"defaultBranch":"master","name":"nnn","ownerLogin":"jarun","currentUserCanPush":false,"isFork":false,"isEmpty":false,"createdAt":"2016-08-20T14:10:14.000Z","ownerAvatar":"https://avatars.githubusercontent.com/u/5959286?v=4","public":true,"private":false,"isOrgOwned":false},"symbolsExpanded":false,"treeExpanded":true,"refInfo":{"name":"master","listCacheKey":"v0:1693110472.0","canEdit":false,"refType":"branch","currentOid":"f2a8648861ff88e1c2d5a95ae4d76b7367e12c9b"},"path":"misc/quitcd/quitcd.fish","currentUser":null,"blob":{"rawLines":["# Rename this file to match the name of the function","# e.g. ~/.config/fish/functions/n.fish","# or, add the lines to the 'config.fish' file.","","function n --wraps nnn --description 'support nnn quit and change directory'","    # Block nesting of nnn in subshells","    if test -n \"$NNNLVL\" -a \"$NNNLVL\" -ge 1","        echo \"nnn is already running\"","        return","    end","","    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)","    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to","    # see. To cd on quit only on ^G, remove the \"-x\" from both lines below,","    # without changing the paths.","    if test -n \"$XDG_CONFIG_HOME\"","        set -x NNN_TMPFILE \"$XDG_CONFIG_HOME/nnn/.lastd\"","    else","        set -x NNN_TMPFILE \"$HOME/.config/nnn/.lastd\"","    end","","    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn","    # stty start undef","    # stty stop undef","    # stty lwrap undef","    # stty lnext undef","","    # The command function allows one to alias this function to `nnn` without","    # making an infinitely recursive alias","    command nnn $argv","","    if test -e $NNN_TMPFILE","        source $NNN_TMPFILE","        rm $NNN_TMPFILE","    end","end"],"stylingDirectives":[[{"start":0,"end":52,"cssClass":"pl-c"},{"start":0,"end":1,"cssClass":"pl-c"}],[{"start":0,"end":38,"cssClass":"pl-c"},{"start":0,"end":1,"cssClass":"pl-c"}],[{"start":0,"end":46,"cssClass":"pl-c"},{"start":0,"end":1,"cssClass":"pl-c"}],[],[{"start":0,"end":8,"cssClass":"pl-k"},{"start":11,"end":18,"cssClass":"pl-s"},{"start":23,"end":36,"cssClass":"pl-s"},{"start":37,"end":76,"cssClass":"pl-s"},{"start":37,"end":38,"cssClass":"pl-pds"},{"start":75,"end":76,"cssClass":"pl-pds"}],[{"start":4,"end":39,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":6,"cssClass":"pl-k"},{"start":7,"end":11,"cssClass":"pl-c1"},{"start":12,"end":14,"cssClass":"pl-s"},{"start":15,"end":24,"cssClass":"pl-s"},{"start":15,"end":16,"cssClass":"pl-pds"},{"start":16,"end":23,"cssClass":"pl-smi"},{"start":23,"end":24,"cssClass":"pl-pds"},{"start":25,"end":27,"cssClass":"pl-s"},{"start":28,"end":37,"cssClass":"pl-s"},{"start":28,"end":29,"cssClass":"pl-pds"},{"start":29,"end":36,"cssClass":"pl-smi"},{"start":36,"end":37,"cssClass":"pl-pds"},{"start":38,"end":41,"cssClass":"pl-s"}],[{"start":8,"end":12,"cssClass":"pl-c1"},{"start":13,"end":37,"cssClass":"pl-s"},{"start":13,"end":14,"cssClass":"pl-pds"},{"start":36,"end":37,"cssClass":"pl-pds"}],[{"start":8,"end":14,"cssClass":"pl-c1"}],[{"start":4,"end":7,"cssClass":"pl-k"}],[],[{"start":4,"end":75,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":76,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":75,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":33,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":6,"cssClass":"pl-k"},{"start":7,"end":11,"cssClass":"pl-c1"},{"start":12,"end":14,"cssClass":"pl-s"},{"start":15,"end":33,"cssClass":"pl-s"},{"start":15,"end":16,"cssClass":"pl-pds"},{"start":16,"end":32,"cssClass":"pl-smi"},{"start":32,"end":33,"cssClass":"pl-pds"}],[{"start":8,"end":11,"cssClass":"pl-c1"},{"start":12,"end":14,"cssClass":"pl-s"},{"start":27,"end":56,"cssClass":"pl-s"},{"start":27,"end":28,"cssClass":"pl-pds"},{"start":28,"end":44,"cssClass":"pl-smi"},{"start":55,"end":56,"cssClass":"pl-pds"}],[{"start":4,"end":8,"cssClass":"pl-k"}],[{"start":8,"end":11,"cssClass":"pl-c1"},{"start":12,"end":14,"cssClass":"pl-s"},{"start":27,"end":53,"cssClass":"pl-s"},{"start":27,"end":28,"cssClass":"pl-pds"},{"start":28,"end":33,"cssClass":"pl-smi"},{"start":52,"end":53,"cssClass":"pl-pds"}],[{"start":4,"end":7,"cssClass":"pl-k"}],[],[{"start":4,"end":68,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":22,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":21,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":22,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":22,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[],[{"start":4,"end":77,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":42,"cssClass":"pl-c"},{"start":4,"end":5,"cssClass":"pl-c"}],[{"start":4,"end":11,"cssClass":"pl-c1"},{"start":16,"end":21,"cssClass":"pl-smi"}],[],[{"start":4,"end":6,"cssClass":"pl-k"},{"start":7,"end":11,"cssClass":"pl-c1"},{"start":12,"end":14,"cssClass":"pl-s"},{"start":15,"end":27,"cssClass":"pl-smi"}],[{"start":15,"end":27,"cssClass":"pl-smi"}],[{"start":8,"end":10,"cssClass":"pl-c1"},{"start":11,"end":23,"cssClass":"pl-smi"}],[{"start":4,"end":7,"cssClass":"pl-k"}],[{"start":0,"end":3,"cssClass":"pl-k"}]],"csv":null,"csvError":null,"dependabotInfo":{"showConfigurationBanner":false,"configFilePath":null,"networkDependabotPath":"/jarun/nnn/network/updates","dismissConfigurationNoticePath":"/settings/dismiss-notice/dependabot_configuration_notice","configurationNoticeDismissed":null,"repoAlertsPath":"/jarun/nnn/security/dependabot","repoSecurityAndAnalysisPath":"/jarun/nnn/settings/security_analysis","repoOwnerIsOrg":false,"currentUserCanAdminRepo":false},"displayName":"quitcd.fish","displayUrl":"https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.fish?raw=true","headerInfo":{"blobSize":"1.16 KB","deleteInfo":{"deleteTooltip":"You must be signed in to make or propose changes"},"editInfo":{"editTooltip":"You must be signed in to make or propose changes"},"ghDesktopPath":"https://desktop.github.com","gitLfsPath":null,"onBranch":true,"shortPath":"a8c3dc4","siteNavLoginPath":"/login?return_to=https%3A%2F%2Fgithub.com%2Fjarun%2Fnnn%2Fblob%2Fmaster%2Fmisc%2Fquitcd%2Fquitcd.fish","isCSV":false,"isRichtext":false,"toc":null,"lineInfo":{"truncatedLoc":"36","truncatedSloc":"31"},"mode":"file"},"image":false,"isCodeownersFile":null,"isPlain":false,"isValidLegacyIssueTemplate":false,"issueTemplateHelpUrl":"https://docs.github.com/articles/about-issue-and-pull-request-templates","issueTemplate":null,"discussionTemplate":null,"language":"fish","languageID":415,"large":false,"loggedIn":false,"newDiscussionPath":"/jarun/nnn/discussions/new","newIssuePath":"/jarun/nnn/issues/new","planSupportInfo":{"repoIsFork":null,"repoOwnedByCurrentUser":null,"requestFullPath":"/jarun/nnn/blob/master/misc/quitcd/quitcd.fish","showFreeOrgGatedFeatureMessage":null,"showPlanSupportBanner":null,"upgradeDataAttributes":null,"upgradePath":null},"publishBannersInfo":{"dismissActionNoticePath":"/settings/dismiss-notice/publish_action_from_dockerfile","dismissStackNoticePath":"/settings/dismiss-notice/publish_stack_from_file","releasePath":"/jarun/nnn/releases/new?marketplace=true","showPublishActionBanner":false,"showPublishStackBanner":false},"rawBlobUrl":"https://github.com/jarun/nnn/raw/master/misc/quitcd/quitcd.fish","renderImageOrRaw":false,"richText":null,"renderedFileInfo":null,"shortPath":null,"tabSize":8,"topBannersInfo":{"overridingGlobalFundingFile":false,"globalPreferredFundingPath":null,"repoOwner":"jarun","repoName":"nnn","showInvalidCitationWarning":false,"citationHelpUrl":"https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/about-citation-files","showDependabotConfigurationBanner":false,"actionsOnboardingTip":null},"truncated":false,"viewable":true,"workflowRedirectUrl":null,"symbols":{"timed_out":false,"not_analyzed":true,"symbols":[]}},"copilotInfo":null,"copilotAccessAllowed":false,"csrf_tokens":{"/jarun/nnn/branches":{"post":"HqdHO6yxxswpp0X0Re2XVwEo4kNe9AH8V0sjyY8eSjob3WJGsOjEuKfkGnxTX5wm7vUwMeBqV6_Qf9F5AWdknA"},"/repos/preferences":{"post":"TMWITXnq_NbLSAiLn-i8a_KtHl48S-tgDvsyvwV5hk-X0DCG7sYi5QK9ULSR8lGORc0OaqWXH5eTXJnk53Fkug"}}},"title":"nnn/misc/quitcd/quitcd.fish at master · jarun/nnn"}