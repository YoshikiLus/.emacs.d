;;elspの最低限の文法
;;関数の実行は()の中
;;  例えば(set 'a 100)
;;普通，変数はその場で評価されてしまう．評価されるのを防ぐには，「'」を変数名の前につける('val)のように．


;;loadpathの追加設定
(add-to-list 'load-path "/Users/freedom/.emacs.d/loadpath")

;; packageの設定
;;(require 'package) ;; You might already have this line
;;(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
;;                    (not (gnutls-available-p))))
;;       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
;;  (add-to-list 'package-archives (cons "melpa" url) t))
;;(when (< emacs-major-version 24)
;;  ;; For important compatibility libraries like cl-lib
;;  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))


(package-initialize) ;; You might already have this line

;;(setq package-archives
;;      '(("gnu" . "http://elpa.gnu.org/packages/")
;;        ("melpa" . "http://melpa.org/packages/")
;;        ("org" . "http://orgmode.org/elpa/")))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives
     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq-default tab-width 4 indent-tabs-mode nil)

;; 日本語をちらつかせない！
(setq redisplay-dont-pause nil)

;;ツールバーを表示しない
(tool-bar-mode 0)

;;メニューバーを表示しない
(menu-bar-mode -1)

;; 括弧の自動補完
(electric-pair-mode 1)


;;; スクロールを一行ずつにする
(setq scroll-step 1)

;; 動的略称展開(dabbrev-expand)にキーバインドを割り当てる
(define-key global-map (kbd "C-:") 'dabbrev-expand)

;;動的略称展開(dabbrev-expand)において大文字・小文字を区別する
(setq dabbrev-case-fold-search nil)
;; goto-lineにキーバインドを割り当てる
(define-key global-map (kbd "M-j") 'goto-line)

;; replace-regexpにキーバインドを割り当てる
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z r") 'replace-regexp)

;; shellの環境変数をEmacsに引き継ぐ
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))



;; browser-kill-ring
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
(global-set-key (kbd "C-x :") 'browse-kill-ring)


;;
(require 'auto-install)

;;(require 'elscreen)
;;(elscreen-set-prefix-key "\C-t")
;;(elscreen-start)

;; use-package
(require 'use-package)

;; powerline
(use-package powerline
  :config
  (powerline-default-theme))
;;company mode
(require 'company)
(global-company-mode) ; 全バッファで有効にする
;;(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

;;補完機能の設定
(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony) ;;backend追加

(eval-after-load "irony"
  '(progn
     (custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
     (add-to-list 'company-backends 'company-irony)
     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
     (add-hook 'c-mode-common-hook 'irony-mode)))


;; 初期画面を表示しない
(setq inhibit-startup-message t)

;; tabbarの設定
;;
(require 'tabbar)
(tabbar-mode)

(tabbar-mwheel-mode nil)                  ;; マウスホイール無効
(setq tabbar-buffer-groups-function nil)  ;; グループ無効
;;(setq tabbar-use-images nil)              ;; 画像を使わない


;;----- キーに割り当てる
(global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)
(global-set-key (kbd "<C-S-tab>") 'tabbar-backward-tab)
;;(global-set-key (kbd "<f8>") 'tabbar-forward-tab)
;;(global-set-key (kbd "<f7>") 'tabbar-backward-tab)
;;(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-x C-n") 'tabbar-forward-tab)
(global-set-key (kbd "C-x C-p") 'tabbar-backward-tab)


;;----- 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))


;;----- タブのセパレーターの長さ
(setq tabbar-separator '(2.0))


;;----- タブの色（CUIの時。GUIの時は後でカラーテーマが適用）
(set-face-attribute
 'tabbar-default nil
 :family "MeiryoKe_Gothic"
 :background "black"
 :foreground "white"
 )
(set-face-attribute
 'tabbar-selected nil
 :background "#ff5f00"
 :foreground "brightwhite"
 )
(set-face-attribute
 'tabbar-unselected nil
 :background "black"
 :foreground "white"
 :box '(:line-width 2 :color "red")
 )
(set-face-attribute
 'tabbar-separator nil
 :background "gray"
 :foreground "gray"
 ;;:box '(:line-width 2 :color "red")
 )
;(set-face-attribute
; 'tabbar-modified nil
;:background "brightred"
;:foreground "brightwhite"
;:box nil
;)

(when window-system                       ; GUI時
  ;; 外観変更
  ;;設定2
  (set-face-attribute
   'tabbar-default nil
   :family "MeiryoKe_Gothic"
   :background "#34495E"
   :foreground "#EEEEEE"
   :box '(:line-width 1 :color "gray20" :style nil))
  
  (set-face-attribute
   'tabbar-unselected nil
   :background "gray30"
   :foreground "white"
   :box '(:line-width 5 :color "gray30" :style nil))
  
  (set-face-attribute
   'tabbar-selected nil
   :background "blue"
   :foreground "#EEEEEE"
   :box '(:line-width 1 :color "gray75" :style nil))
  
  (set-face-attribute
   'tabbar-highlight nil
   :background "white"
   :foreground "black"
   :underline nil
   :box '(:line-width 5 :color "white" :style nil))
  
  (set-face-attribute
   'tabbar-button nil
   :box '(:line-width 1 :color "gray20" :style nil))
  
  (set-face-attribute
   'tabbar-separator nil
   :background "gray20"
   :height 0.6)


  ;;設定1
  ;; (set-face-attribute
  ;;  'tabbar-default nil
  ;;  :family "MeiryoKe_Gothic"
  ;;  :background "#34495E"
  ;;  :foreground "#EEEEEE"
  ;;  :height 0.85
  ;;  ;; :box '(:line-width 2 :color "white")
  ;;  )
  ;; (set-face-attribute
  ;;  'tabbar-unselected nil
  ;;  :family "Meiryoke_Gothic"
  ;;  :background "black"
  ;;  :foreground "white"
  ;;  :box '(:line-width 2 :color "white")
  ;;  :box nil
  ;;  )
  ;; (set-face-attribute
  ;;  'tabbar-separator nil
  ;;  :background "gray"
  ;;  :foreground "gray"
  ;;  :box '(:line-width 2 :color "white")
  ;;  )
  ;; (set-face-attribute
  ;;  'tabbar-selected nil
  ;;  :background "#E74C3C"
  ;;  :foreground "#EEEEEE"
  ;;  :box '(:line-width 2 :color "white")
  ;;  :box nil)
  ;; (set-face-attribute
  ;;  'tabbar-button nil
  ;;  :box nil)
  ;; (set-face-attribute
  ;;  'tabbar-separator nil
  ;;  :height 2.0)
  )


;; Change padding of the tabs
;; we also need to set separator to avoid overlapping tabs by highlighted tabs
;; (custom-set-variables
;; (custom-set-variables
;;  '(tabbar-separator (quote (0.5))))
;; ;; adding spaces
;; (defun tabbar-buffer-tab-label (tab)
;;   "Return a label for TAB.
;; That is, a string used to represent it on the tab bar."
;;   (let ((label  (if tabbar--buffer-show-groups
;;                     (format "[%s]  " (tabbar-tab-tabset tab))
;;                   (format "%s  " (tabbar-tab-value tab)))))
;;     ;; Unless the tab bar auto scrolls to keep the selected tab
;;     ;; visible, shorten the tab label to keep as many tabs as possible
;;     ;; in the visible area of the tab bar.
;;     (if tabbar-auto-scroll-flag
;;         label
;;       (tabbar-shorten
;;        label (max 1 (/ (window-width)
;;                        (length (tabbar-view
;; (tabbar-current-tabset)))))))))


;;----- タブに表示するバッファの設定
(defun my-tabbar-buffer-list ()
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                     ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
                     ((equal "*OCaml*" (buffer-name b)) b) ;*OCamlバッファも表示する*
                     ((equal "*shell*" (buffer-name b)) b) ;*shell*バッファも表示する
                     ((equal "*shell*<2>" (buffer-name b)) b) ;*shell*バッファも表示する
                     ((equal "*shell*<3>" (buffer-name b)) b) ;*shell*バッファも表示する
                     ((equal "*shell*<4>" (buffer-name b)) b) ;*shell*バッファも表示する
                     ((equal "*shell*<5>" (buffer-name b)) b) ;*shell*バッファも表示する
                     ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)


;; helmの設定
;;(package-install 'helm)
(require 'helm-config)
(helm-mode 1)
;;(helm-migemo-mode 1)


;; C-hで前の文字削除
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;;(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;;(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)


;; キーバインド
(global-set-key (kbd "C-o") 'helm-mini)
(global-set-key (kbd "C-c a") 'helm-do-ag)
(global-set-key (kbd "C-c h") 'helm-mini)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
;;(define-key global-map (kbd "C-x b") 'helm-for-files)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)

(add-to-list 'helm-completing-read-handlers-alist '(write-file . nil))

;; タイトルパーにファイルのフルパスを表示する
(setq frame-title-format "%f")


;;キーバインド

(define-key global-map [?¥] [?\\])     ;;
(unless window-system
  (global-set-key (kbd "M-n") 'beginning-of-buffer)
  )
(define-key global-map (kbd "C-,") 'beginning-of-buffer)     ;;
(unless window-system
  (global-set-key (kbd "M-m") 'end-of-buffer)
  )
(define-key global-map (kbd "C-.") 'end-of-buffer)
(define-key global-map (kbd "C-x C-/") 'eval-buffer)

;; 行数を表示する
(global-linum-mode t)


;; 改行コードを表示する
;;(setq eol-mnemonic-dos "(CRLF)")
;;(setq eol-mnemonic-mac "(CR)")
;;(setq eol-mnemonic-unix "(LF)")

;;特殊文字に関する表示設定
(require 'whitespace)
;; スペースの定義は全角スペースとする。
(setq whitespace-trailing-regexp  "\\([ \u00A0]+\\)$")
(setq whitespace-space-regexp "\\(\u3000+\\)")
(defvar my/bg-color "#232323")

;;whitespace-space-regexp


;;具体的な設定
(set-face-foreground 'whitespace-space "white40")
(set-face-bold-p 'whitespace-space t)
(set-face-underline  'whitespace-space t)
(set-face-foreground 'whitespace-newline  "gray28")        ;;改行文字の色
;;(set-face-background 'whitespace-newline "gray28")

;;特殊文字を表示させる
(global-whitespace-mode 1)


;; M-ESC ESC による ウィンドウの単一化を無効化
(define-key global-map (kbd "M-ESC ESC") nil)


;; 列数を表示する
(column-number-mode t)

;; 対応する括弧を光らせる
(show-paren-mode t)
(put 'upcase-region 'disabled nil)

;良くわからないcamlモード．謎
;; (setq auto-mode-alist
;; (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
;; (autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
;; (autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)
;;(if window-system (require 'caml-font))
;;(setq inferior-caml-program "/usr/local/bin/ocaml")

;;tuaregの設定
'(load "'"$HOME"'/.opam/system/share/emacs/site-lisp/tuareg-site-file")'
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
(autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
(autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)




;;テーマの設定
;;(set-face-background 'default "#303030")
;;(set-foreground-color "#ffffff")
(load-theme 'deeper-blue t)
(unless window-system
  (load-theme 'manoj-dark t)
  )


;; run yatex mode when open .tex file
(setq auto-mode-alist
(cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(setq dviprint-command-format "dvipdfmx %s")

;; yatex load path
(setq load-path (cons (expand-file-name
"/Applications/Emacs.app/Contents/Resources/site-lisp/yatex")
load-path))
;; use utf-8 on yatex mode
(setq YaTeX-kanji-code 4)

;; preview
(setq dvi2-command "open -a Preview")
(defvar YaTeX-dvi2-command-ext-alist
  '(("xdvi" . ".dvi")
    ("ghostview\\|gv" . ".ps")
    ("acroread\\|pdf\\|Preview\\|open" . ".pdf")))

;;yatexにアウトライン機能を追加
(defun latex-outline-level ()
  (interactive)
  (let ((str nil))
	(looking-at outline-regexp)
	(setq str (buffer-substring-no-properties (match-beginning 0) (match-end 0)))
	(cond ;; キーワード に 階層 を返す
	 ((string-match "documentclass" str) 1)
	 ((string-match "documentstyle" str) 1)
	 ((string-match "part" str) 2)
	 ((string-match "chapter" str) 3)
	 ((string-match "appendix" str) 3)
	 ((string-match "subsubsection" str) 6)
	 ((string-match "subsection" str) 5)
	 ((string-match "section" str) 4)
	 (t (+ 6 (length str)))
	 )))

(add-hook 'yatex-mode-hook
		  '(lambda ()
			 (setq outline-level 'latex-outline-level)
			 (make-local-variable 'outline-regexp)
			 (setq outline-regexp
				  (concat "[ \t]*\\\\\\(documentstyle\\|documentclass\\|"
				          "part\\|chapter\\|appendix\\|section\\|subsection\\|subsubsection\\)"
				          "\\*?[ \t]*[[{]"))
			 (outline-minor-mode t)))


(require 'multi-eshell)

(require 'undo-tree)
(global-undo-tree-mode)

;;---------------------------------
;;(diredの設定)
;; Open each of the marked files, or the file under the point, or when prefix arg, the next N files 

(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map "F" 'my-dired-find-file)
     (defun my-dired-find-file 
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))))

;; unzip with dired
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes 
                 '("\\.zip\\'" ".zip" "unzip")))

(eval-after-load "dired"
  '(define-key dired-mode-map "z" 'dired-zip-files))
(defun dired-zip-files (zip-file)
  "Create an archive containing the marked files."
  (interactive "sEnter name of zip file: ")

  ;; create the zip file
  (let ((zip-file (if (string-match ".zip$" zip-file) zip-file (concat zip-file ".zip"))))
    (shell-command 
     (concat "zip " 
             zip-file
             " "
             (concat-string-list
              (mapcar
               '(lambda (filename)
                  (file-name-nondirectory filename))
               (dired-get-marked-files))))))
  (revert-buffer)

  ;; dired-find-alternate-file の有効化
  (put 'dired-find-alternate-file 'disabled nil)
  ;; ファイルなら別バッファで、ディレクトリなら同じバッファで開く
  (defun dired-open-in-accordance-with-situation ()
    (interactive)
    (let ((file (dired-get-filename)))
      (if (file-directory-p file)
          (dired-find-alternate-file)
        (dired-find-file))))
  ;; RET 標準の dired-find-file では dired バッファが複数作られるので
  ;; dired-find-alternate-file を代わりに使う
  (define-key dired-mode-map (kbd "RET") 'dired-open-in-accordance-with-situation)
  (define-key dired-mode-map (kbd "a") 'dired-find-file)
  ;;
  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key dired-mode-map (kbd "^")
                (lambda () (interactive) (find-alternate-file "..")))
                                        ; was dired-up-directory
              ))

  
  ;; remove the mark on all the files  "*" to " "
  ;; (dired-change-marks 42 ?\040)
  ;; mark zip file
  ;; (dired-mark-files-regexp (filename-to-regexp zip-file))
  )

(defun concat-string-list (list) 
   "Return a string which is a concatenation of all elements of the list separated by spaces" 
    (mapconcat '(lambda (obj) (format "%s" obj)) list " ")) 


;;----------------------------------

;; (require 'yasnippet)
;; (yas-global-mode)
;; (eval-after-load "yasnippet"
;;   '(progn
;;      ;; companyと競合するのでyasnippetのフィールド移動は "C-i" のみにする
;;      (define-key yas-keymap (kbd "<tab>") nil)
;;      (yas-global-mode 1)))

;; 自分用・追加用テンプレート -> mysnippetに作成したテンプレートが格納される
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
        "~/.emacs.d/yasnippets"
        ))

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

(yas-global-mode 1)



(global-set-key (kbd "C-k") 'kill-line)

;; line_copy
(fset 'line_copy
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([67108896 5 escape 119] 0 "%d")) arg)))

(global-set-key (kbd "C-z k") 'line_copy)





;; 環境を日本語、UTF-8にする
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)


;; visual-regexp-steroidsの導入
(require 'visual-regexp-steroids)
(setq vr/engine 'python)


(setq scroll-step 1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-empty ((t nil)))
 '(whitespace-indentation ((t nil)))
 '(whitespace-line ((t nil)))
 '(whitespace-space ((t (:background "gray100" :foreground "grey" :underline t :weight bold))))
 '(whitespace-space-after-tab ((t nil)))
 '(whitespace-space-before-tab ((t (:background "DarkOrange" :foreground "firebrick"))))
 '(whitespace-trailing ((t nil))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(desktop-globals-to-save
   (quote
    (desktop-missing-file-warning tags-file-name tags-table-list search-ring regexp-search-ring register-alist file-name-history kill-ring)))
 '(desktop-save-mode t)
 '(irony-additional-clang-options (quote ("-std=c++11")))
 '(package-selected-packages
   (quote
    (restart-emacs tuareg yasnippet-snippets company auto-complete cedit yasnippet undo-tree multi-eshell auto-install elscreen elscreen-fr use-package rainbow-mode powerline perspective package-utils helm-perspeen company-irony browse-kill-ring+ apel))))

(setq auto-mode-alist (cons '("¥¥.ml¥¥w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
