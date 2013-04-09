;; load-path ��ǉ�����֐����`
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; �����̃f�B���N�g���Ƃ��̃T�u�f�B���N�g����load-path�ɒǉ�
(add-to-load-path "elisp" "conf" "public_repos")

;; �o�b�N�A�b�v�ƃI�[�g�Z�[�u�t�@�C����~/.emacs.d/backups/�֏W�߂�
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))


;;; �����R�[�h���w�肷��
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;;; �t�@�C�����̈���
;; Mac OS X�̏ꍇ�̃t�@�C�����̐ݒ�
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; Windows�̏ꍇ�̃t�@�C�����̐ݒ�
(when (eq window-system 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))


;;; �^�C�g���o�[�Ƀt�@�C���̃t���p�X��\��
(setq frame-title-format "%f")

;; TAB�̕\�����B�����l��8
(setq-default tab-width 4)

;;; �\���e�[�}�̐ݒ�
;; http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.zip
(when (require 'color-theme nil t)
;;�e�[�}��ǂݍ��ނ��߂̐ݒ�
(color-theme-initialize)
;;�e�[�}hober�ɕύX����
(color-theme-hober))


;;; �t�H���g�̐ݒ�
(when (eq window-system 'ns)
  ;; ascii�t�H���g��Menlo��
  (set-face-attribute 'default nil
                      :family "Menro"
                      :height 120)
  ;; ���{��t�H���g���q���M�m���� Pro��
  (set-fontset-font
   nil 'japanese-jisx0208
   ;; �p�ꖼ�̏ꍇ
   ;; (font-spec :family "Hiragino Mincho Pro"))
   (font-spec :family "�q���M�m���� Pro"))
  ;; �Ђ炪�ȂƃJ�^�J�i�����g���V�[�_��
  ;; U+3000-303F	CJK�̋L������ы�Ǔ_
  ;; U+3040-309F	�Ђ炪��
  ;; U+30A0-30FF	�J�^�J�i
  (set-fontset-font
   nil '(#x3040 . #x30ff)
   (font-spec :family "NfMotoyaCedar"))
  ;; �t�H���g�̉����𒲐߂���
  (setq face-font-rescale-alist
        '((".*Menlo.*" . 1.0)
          (".*Hiragino_Mincho_Pro.*" . 1.2)
          (".*nfmotoyacedar-bold.*" . 1.2)
          (".*nfmotoyacedar-medium.*" . 1.2)
          ("-cdac$" . 1.3))))

(when (eq system-type 'windows-nt)
  ;; ascii�t�H���g��Consolas��
  (set-face-attribute 'default nil
                      :family "Consolas"
                      :height 120)
  ;; ���{��t�H���g�����C���I��
  (set-fontset-font
   nil
   'japanese-jisx0208
   (font-spec :family "���C���I"))
  ;; �t�H���g�̉����𒲐߂���
  (setq face-font-rescale-alist
        '((".*Consolas.*" . 1.0)
          (".*���C���I.*" . 1.15)
          ("-cdac$" . 1.3))))


;;; ���ݍs�̃n�C���C�g
(defface my-hl-line-face
  ;; �w�i��dark�Ȃ�Δw�i�F������
  '((((class color) (background dark))
     (:background "NavyBlue" t))
    ;; �w�i��light�Ȃ�Δw�i�F��΂�
    (((class color) (background light))
     (:background "LightGoldenrodYellow" t))
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

;; ���ʂ̑Ή��֌W�̃n�C���C�g
;; paren-mode�F�Ή����銇�ʂ��������ĕ\������
(setq show-paren-delay 0) ; �\���܂ł̕b���B�����l��0.125
(show-paren-mode t) ; �L����
;; paren�̃X�^�C��: expression�͊��ʓ��������\��
(setq show-paren-style 'expression)
;; �t�F�C�X��ύX����
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; cua-mode�̐ݒ�
(cua-mode t) ; cua-mode���I��
(setq cua-enable-cua-keys nil) ; CUA�L�[�o�C���h�𖳌��ɂ���

;;; C-h���o�b�N�X�y�[�X�ɂ���
;; ���͂����L�[�V�[�P���X��u��������
;; ?\C-?��DEL�̃L�[�V�P���X
(keyboard-translate ?\C-h ?\C-?)

;;; �����߂̃L�[����
;; C-m��newline-and-indent�����蓖�Ă�B
;; ��قǂƂ͈قȂ�global-set-key�𗘗p
(global-set-key (kbd "C-m") 'newline-and-indent)
;; �܂�Ԃ��g�O���R�}���h
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)
;; "C-t" �ŃE�B���h�E��؂�ւ���B�����l��transpose-chars
(define-key global-map (kbd "C-t") 'other-window)

;;; P65 CUI��GUI�ɂ�镪��
;; �^�[�~�i���ȊO�̓c�[���o�[�A�X�N���[���o�[���\��
(when window-system
  ;; tool-bar���\��
  (tool-bar-mode 0)
  ;; scroll-bar���\��
  (scroll-bar-mode 0))

;;; �g���@�\�������C���X�g�[������auto-install
;; auto-install�̐ݒ�
(when (require 'auto-install nil t)
  ;; �C���X�g�[���f�B���N�g����ݒ肷�� �����l�� ~/.emacs.d/auto-install/
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWiki�ɓo�^����Ă���elisp �̖��O���擾����
  (auto-install-update-emacswiki-package-name t)
  ;; install-elisp �̊֐��𗘗p�\�ɂ���
  (auto-install-compatibility-setup))

;; redo+�̐ݒ�
(when (require 'redo+ nil t)
  ;; C-. �Ƀ��h�D�����蓖�Ă�
  (global-set-key (kbd "C-.") 'redo)
  )

;; package.el�̐ݒ�
(when (require 'package nil t)
  ;; �p�b�P�[�W���|�W�g����Marmalade�ƊJ���҉^�c��ELPA��ǉ�
  (add-to-list 'package-archives
			   '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  ;; �C���X�g�[�������p�b�P�[�W�Ƀ��[�h�p�X��ʂ��ēǂݍ���
  (package-initialize))

;;; ���I���^�C���^�t�F�[�X����Anything
;; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   ;; ����\������܂ł̎��ԁB�f�t�H���g��0.5
   anything-idle-delay 0.3
   ;; �^�C�v���čĕ`�ʂ���܂ł̎��ԁB�f�t�H���g��0.1
   anything-input-idle-delay 0.2
   ;; ���̍ő�\�����B�f�t�H���g��50
   anything-candidate-number-limit 100
   ;; ��₪�����Ƃ��ɑ̊����x�𑁂�����
   anything-quick-update t
   ;; ���I���V���[�g�J�b�g���A���t�@�x�b�g��
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root�����ŃA�N�V���������s����Ƃ��̃R�}���h
    ;; �f�t�H���g��"su"
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
    ;; lisp�V���{���̕⊮���̍Č�������
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    ;; describe-bindings��Anything�ɒu��������
    (descbinds-anything-install)))

;;; �ߋ��̗�������y�[�X�g����anything-show-kill-ring
;; M-y��anything-show-kill-ring�����蓖�Ă�
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;;; moccur�𗘗p���鄟��anything-c-moccur
(when (require 'anything-c-moccur nil t)
  (setq
   ;; anything-c-moccur�p `anything-idle-delay'
   anything-c-moccur-anything-idle-delay 0.1
   ;; �o�b�t�@�̏����n�C���C�g����
   anything-c-moccur-higligt-info-line-flag t
   ;; ���ݑI�𒆂̌��̈ʒu���ق���window�ɕ\������
   anything-c-moccur-enable-auto-look-flag t
   ;; �N�����Ƀ|�C���g�̈ʒu�̒P��������p�^�[���ɂ���
   anything-c-moccur-enable-initial-pattern t)
  ;; C-M-o��anything-c-moccur-occur-by-moccur�����蓖�Ă�
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))

;;; auto-complete�̐ݒ�
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories 
    "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;;; �������ʂ����X�g�A�b�v���鄟��color-moccur
;; color-moccur�̐ݒ�
(when (require 'color-moccur nil t)
  ;; M-o��occur-by-moccur�����蓖��
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; �X�y�[�X��؂��AND����
  (setq moccur-split-word t)
  ;; �f�B���N�g�������̂Ƃ����O����t�@�C��
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  ;; Migemo�𗘗p�ł�����ł����Migemo���g��
  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (setq moccur-use-migemo t)))

;;; moccur�̌��ʂ𒼐ڕҏW����moccur-edit
;; moccur-edit�̐ݒ�
 (require 'moccur-edit nil t)
;; moccur-edit-finish-edit�Ɠ����Ƀt�@�C����ۑ�����
 (defadvice moccur-edit-change-file
   (after save-after-moccur-edit-buffer activate)
   (save-buffer))

;;; ���������EToDo�Ǘ�����howm
;; howm�����ۑ��̏ꏊ
(setq howm-directory (concat user-emacs-directory "howm"))
;; howm-menu�̌������{���
(setq howm-menu-lang 'ja)
;; howm������1��1�t�@�C���ɂ���
; (setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
;; howm-mode��ǂݍ���
(when (require 'howm-mode nil t)
  ;; C-c,,��howm-menu���N��
  (define-key global-map (kbd "C-c ,,") 'howm-menu))

;; howm������ۑ��Ɠ����ɕ���
(defun howm-save-buffer-and-kill ()
  "howm������ۑ��Ɠ����ɕ��܂��B"
  (interactive)
  (when (and (buffer-file-name)
             (string-match "\\.howm" (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))

;; C-c C-c�Ń����̕ۑ��Ɠ����Ƀo�b�t�@�����
(define-key howm-mode-map (kbd "C-c C-c") 'howm-save-buffer-and-kill)

;; perl-mode��cperl-mode�̃G�C���A�X�ɂ���
(defalias 'perl-mode 'cperl-mode)