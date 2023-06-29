###### Errors I Faced in whatsy app

# [RetrievalTimeoutHelper] Timed out waiting for SMS.

- enable Google Play Integrity API from [google cloud website].

# how to keep the same instance on both two screens?

- you must use [BlocProvider.value] to keep the same instance on both [LoginView] & [VerifyView]
  screens.

# unable to process request due to missing initial state. this may happen if browser session storages inaccessible or accidentally cleared.

### very important
# To update data in realtime database in ref you should to set dot before writing any path like this [ref('.info/connected)].
