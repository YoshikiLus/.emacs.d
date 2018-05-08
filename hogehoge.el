;; 色設定
(set-face-attribute ; バー自体の色
  'tabbar-default nil
   :background "white"
   :family "Inconsolata"
   :height 1.0)
(set-face-attribute ; アクティブなタブ
  'tabbar-selected nil
   :background "black"
   :foreground "white"
   :weight 'bold
   :box nil)
(set-face-attribute ; 非アクティブなタブ
  'tabbar-unselected nil
   :background "white"
   :foreground "black"
   :box nil)
