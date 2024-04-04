# minitester
Output tester for the 42 Common Core 'minishell' project | Made to help during the development stages | On going

Prerequisites:
- Your shell executable must have functional prompt capturing and processing capabilities
- Your executable must be compiled without -fsanitize statements, as it would alter minitester's results


Instructions:
- Place the 'minitester' folder next to your minishell executable
- Enter the 'minitester' folder and run:
chmod 777 ./minitester.sh;
bash ./minitester.sh [bonus] [exact]
- It takes a few seconds to get the output. More than a minute of waiting can mean an error occured.
  Depending on the stage of development of your minishell, it is possible for the minitester to get stuck on certain tests.
  If this happens, abort the process and either correct that scenario, or delete the corresponding test line in the tests file before running minitester again.
  In either case, look for the "res[test number]" file left in the minitester folder and go to the corresponding tested file line to get the corresponding test.


Evaluating the results:
- Check individual tests by comparing the output of the files within the 'out_bash' and 'out_minishell' folders.
For this, look for matching filenames in both folders in the format 'res + test number'
- Check the content of the performed test in the 'test_list' folder (test + test number + .sh)
- At the time of writing, this program has not been tested against final minishell projects.
Please, see this program as an auxiliar program and not as a means of final testing.


Further usage:
- You can add more tests by adding new lines to the "tests.txt" file within the 'minitester' folder.
- The optional bonus rule runs the "tests_bonus.txt" file instead of "tests.txt" for people doing bonuses.
- The optional exact rule takes into account if your minishell has the exact same error messages as bash.
  Note that the "bash" word is substituted my "minishell" in the list of bash results so as to account for this.
- At the time of writing, prompts containing parenthesis have not been properly verified


Thanks!
