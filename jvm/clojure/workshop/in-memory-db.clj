;;; Create an in-memory database implementation.  The database
;;; interface will live in the Clojure REPL and implement functions to
;;; create and drop tables, as well as to insert and read records.
(def memory-db (atom {}))
(defn read-db [] @memory-db)
(defn write-db [new-db] (reset! memory-db new-db))

;;; The data structure has this shape:
;;;    {:table-1 {:data [] : indexes {}} :table-2 {:data [] : indexes {}}}

;;; Create the helper functions

;;; Create the `create-table` function. This function takes one
;;; parameter: the table name. It should add a new key (the table
;;; name) at the root of the database, and the value should be a map
;;; containing two entries, and empty vector at the `data` key and an
;;; empty map at the `indexes` key.
(defn create-table
  [table-name]
  (let [table (keyword table-name)
        db (read-db)
        db (into db {table {:data [] :indexes {}}})]
    (write-db db)))

;;; Create the `drop-table` function such that it takes one parameter
;;; as well - the table name. It should remove a table, including all
;;; its data and indexes from the database.
(defn drop-table
  [table-name]
  (let [table (keyword table-name)
        db (read-db)
        db (dissoc db table)]
    (write-db db)))

;;; Create an `insert` function. This function should take three
;;; parameters: `table`, `record` and `id-key`. The `record` parameter
;;; is a map, and `id-key` corresponds to a key in the record map that
;;; will be used as a unique index. For now, this will not handle
;;; cases when a table does not exist or when an index key already
;;; exists in a given table.
(defn insert
  [table record id-key]
  (let [db (read-db)
        key (record id-key)]
    (if (get-in db [table :indexes id-key key])
      (println (str "Record with " id-key " " key " already exists. Aborting"))
      (let [pos (count (get-in db [table :data]))
            indexes (or (get-in db [table :indexes]) {id-key {}})
            indexes (assoc-in indexes [id-key key] pos)
            db (update-in db [table :data] conj record)
            db (assoc-in db [table :indexes] indexes)]
        (write-db db)))))

;;; Create a `select-*` function that will return all the records of a
;;; table passed as a parameter.
(defn select-*
  [table]
  (let [db (read-db)]
    (get-in db [table :data])))

;;; Create a `select-*-where` function that takes three arguments:
;;; `table`, `field`, and `field-value`. The function should use
;;; the index map to retrieve the index of the record in the data
;;; vector and return the element.
(defn select-*-where
  [table field field-value]
  (let [db (read-db)
        index (get-in db [table :indexes field field-value])]
    ((get-in db [table :data]) index)))
