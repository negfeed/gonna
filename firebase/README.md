# Firebase Project Directory

This directory contains server side code and configuration such as functions and firestore ACLs.

## How to ...?

### Figure out which project is current

```sh
$ firebase projects:list
```

The current project will have a '(current)' annotation in the `Project ID` column.

### Switch current project

```sh
$ firebase us <alias or project ID>
```

### Deploy functions only

```sh
$ firebase deploy --only functions
```

### Deploy storage access rules

```sh
$ firebase deploy --only storage
```

### Switch targeted projects

```sh
$ firebase use <project_id>
```
