---
date: 2023-08-06 19:19:41Z
title: Conditional to the Rescue
url: /2023/08/06/conditional-to-the-rescue
---

Not being a prolific GitHub user, I don't get any spam from my git email (actually I even got one meaningful connection!). That changed recently, when a commit was detected by a git (in this case GitHub) scanning company as exposing secrets. However, the commit was only exposing the secret name and I don't see an easy way around that since the script doing that is going inside a public Docker container anyway. While they make it easy for you to have them ignore that content or unsubscribe altogether (although when clicking the links in the email I found myself in a GitHub OAuth screen for their application), this reminds me; maybe I shouldn't show a real email in my git commits.

The reason I've configured a real email address in my git settings is because it felt weird for me to display a GitHub no-reply address for my GitLab commits and vice versa. Well, with everything else in life, that problem can be solved by introducing a conditional, or two:

```
[includeIf "hasconfig:remote.*.url:git@github.com:*/*"]
  path = ~/.config/git/github.user
[includeIf "hasconfig:remote.*.url:git@gitlab.com:*/*"]
  path = ~/.config/git/gitlab.user
```

and in the `github.user` and `gitlab.user` files you would set their respective no-reply email addresses under a `[user]` section. You also don't have to repeat yourself for other user settings, like `name`, you can still have a `[user]` anywhere else. You can also provide a fallback email within the additional `[user]` section, which would be used if a repository doesn't match these conditions.

The remote URLs are being evaluated by the regular globbing rules (and two additional ones), so the [documentation](https://git-scm.com/docs/git-config#_conditional_includes) should be of help for more advanced/streamlined patterns.
