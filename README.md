# treport

Fast and easy time tracking and daily reports for Org Mode.

## Installation

Download `treport.el`, put it to your load path and include to your `init.el`

```
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'treport)
```

## Configuration

Before you can use treport, you must set some configuration.

Create directory `~/OrgMode/reports`

Create file `~/OrgMode/DailyLogEthalon.org`. For example:

```
* Work
** Work: Development
** Work: Mail and IM
** Work: Meeting
** Work: Other
* Personal
** Personal: Time analyze
** Personal: Learning
** Personal: Development
** Personal: Other
* Family

Done:

```

Set time spent categories to `treport/time-spent-categories` variable. For example:

```
(setq treport/time-spent-categories '((?1 "Work" nil ((?1 "Development" "Work: Development" nil)
							   (?2 "Handmade" "Work: Handmade" nil)
							   (?3 "Mail and IM" "Work: Mail and IM" nil)
							   (?4 "Meetings" "Work: Meeting" nil)
							   (?5 "Other" "Work: Other" nil)))
				     (?2 "Personal" nil ((?1 "Planning" "Personal: Planning" nil)
							 (?2 "Analyzing of time spent" "Personal: Time analyze" nil)
							 (?3 "Learning" "Personal: Learning" nil)
							 (?4 "Development" "Personal: Development" nil)
							 (?5 "Other" "Personal: Other" nil)))
				     (?3 "Family" "Family" nil)))
```

Bind keys. For example:

```
(global-set-key (kbd "C-c i") #'treport/log-time-to-category)
(global-set-key (kbd "C-c d") #'treport/log-done-thing)
```

If you want automatically clock out current task when you leaving Emacs, add this hook:

```
(add-hook 'kill-emacs-hook #'treport/exit)
```

## Usage

![1](https://raw.githubusercontent.com/char16t/i/master/treport-1.png)
![2](https://raw.githubusercontent.com/char16t/i/master/treport-2.png)
![3](https://raw.githubusercontent.com/char16t/i/master/treport-3.png)
![4](https://raw.githubusercontent.com/char16t/i/master/treport-4.png)

*On example in screenshots was pressed* `C-c i 1 3`

When you start working with Emacs you don't need to create a new file
`daily-log<current date>.org`. It will be created every day automatically.

All you have to do is press `C-c i` and select the category of tasks over which
you start to work. The clock starts to count time of work on the chosen task.
When you finish a task you have to press `C-c d` and enter details if you want.
Then again press `C-c i` and choose a category. At the end of the day you close
Emacs and clock out occurs.

At the end of the day you can open your file `daily-log-<current date>.org` to
build time table provided by Org Mode. You also can add tables to your ethalon
and rebuild tables with `C-u C-c C-x C-u`.

## License

MIT


