# Introduction  
Purpose of this document is to describe command line interface for Pharo launcher with description of necessary commands.  

# Plans
1. At first, estabilish structure/design of cmd-line interface and what operations, arguments should be supported (this document).
2. Implement stub of cmd-line interface using CLAP. It won't contain necessary connection to Pharo launcher commands yet.
3. If cmd-line design is good to go, we can start on moving Pharo launcher backend code to dedicated package, which could be used by CLAP commands in previous step.
4. Build of headless Pharo launcher (resulting in change of Pharo launcher baseline and change of corresponding Github actions) can be then initiated. Resulting app (executable) will no longer open UI of Pharo launcher. 

# Open questions
1. What if there is some interaction needed? E.g. network is unavailable, should we offer dialog-like options (e.g.: "Reconnect Y/N?"), or rather to avoid that?
2. What is priority of every command? I guess some of them are more important than others (order of how it should be implemented).
3. How to escape path parameters? What type of quotes should be used? (single like 'path to dir' or rathter "this is path"
4. How to print-out errors? Some kind of formatting? (E.g. "ERROR: Could not create image to directory: usr/local/Pharo/images")
5. How to display progress (if ever)? This could be useful during downlaod commands, like "INFO: Fetching from remote-site URL..." (dot's added every second, or maybe percentage?).


