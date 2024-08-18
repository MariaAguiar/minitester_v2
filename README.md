# minitester
Output tester for the 42 Common Core 'minishell' project | Made to help during the development stages | On going

Prerequisites:
- Your shell executable must have functional prompt capturing and processing capabilities


Instructions:
- Place the 'minitester' folder next to your minishell executable
- Enter the 'minitester' folder and run:
chmod +rwx ./minitester.sh;
bash ./minitester.sh [-v]
- It takes a few seconds to get the output, especially if run with the valgrind option ([-v]). A waiting time of several minutes may indicate an error, or possibly that the tester got stuck on certain tests. After a successful run, all created folders and files will be deleted. The exceptions are test results with unexpected outputs. In this case, a "out_leaks" folder will be left on the minitester, containing the test outputs that might have problems for your later analysis. In this case, "res[test number]" is the result of your minishell to "test[test_number] contained in the test_list" folder.


Evaluating the results:
- Individual tests where your minishell got the same exact results as bash will be marked with "OK", while different outputs are presented as "KO" [test] [bash result] [minishell result]
- If you have a [out_leaks] folder by the end of the program's execution, you may have leaks (either with valgrind or -fsanitize). You can check the suspected tests left in this folder for further analysis


Further usage:
- You can add more tests by adding new files named "test[test_number]" to the "test_list" folder while respecting the test order and numbering


Thanks!
