# ChargeBuddy_frontend

## Using Drift
[Drift documentation](https://drift.simonbinder.eu/setup/)

Drift needs to convert the code from database.dart to SQL
This is done by running the following command in the terminal:
```bash
dart run build_runner build
```
This needs to be done every time the database.dart file is changed.

To create a drift schema, run the following command in the terminal:
```bash
dart run drift_dev make-migrations
```
> [!CAUTION]
> The schemaVersion in database.dart should be updated, when creating a new schema.

This should also be done every time the database.dart file is changed,
but only after the database has been created.