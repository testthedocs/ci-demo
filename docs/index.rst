=============
Documentation
=============

Configuration
=============

SSH Local
=========

Add the Gitea container/instance to your *local** (``~/.ssh/config``) SSH configuration.

.. code-block:: bash

   Host git.sven.io
   Hostname git.sven.io
   User git
   Port 222
   IdentityFile ~/.ssh/$YOURKEY

Gitea
=====

- Set domain (git.sven.io)
- Set DB type
- Set Admin user/pass
- Upload SSH key


a989793ad9ebc3aa89a167d42d5a013606e64be9