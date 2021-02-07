(ns my-hiccup
  (:require [clojure.string :as str]))

;;; Some tags are generally not closed
(def unclosed-tags #{:link :meta :br :input :img})

(defn mk-unclosed-tag
  ([tag attrs] (let [tag-name (name tag)]
                 (str "<" tag-name attrs ">"))))

(defn mk-open-tag
  ([tag] (mk-open-tag tag nil))
  ([tag attrs] (if (unclosed-tags tag)
                 (mk-unclosed-tag tag attrs)
                 (let [tag-name (name tag)]
                   (str "<" tag-name attrs ">")))))

(defn mk-single-tag
  ([tag] (mk-single-tag ""))
  ([tag attrs] (if (unclosed-tags tag)
                 (mk-unclosed-tag tag attrs)
                 (let [tag-name (name tag)]
                   (str "<" tag-name attrs "/>")))))

(defn mk-close-tag [tag]
  (let [tag-name (name tag)]
    (str "</" tag-name ">")))

(defn kv->str [[k v]] (str " " (name k) "=\"" v "\""))

(defn map->str [m]
  (apply str (mapcat kv->str m)))

(defn my-hiccup* [doc]
  (reduce (fn [acc [kw & params :as doc]]
            (let [param-map (loop [vs params
                                   m {}]
                              (if (not vs)
                                m
                                (let [v (first vs)
                                      kv (cond (map? v) [:map v]
                                               (vector? v) [:content (my-hiccup* v)]
                                               :else [:content v])]
                                  (recur (next vs) (update-in m [(kv 0)] conj (kv 1))))))
                  ms (:map param-map)
                  attrs (when ms (str/join (map map->str ms)))
                  open-tag (mk-open-tag kw attrs)
                  ps (reverse (:content param-map))
                  content (str/join ps)
                  close-tag (mk-close-tag kw)]
              (str acc open-tag content close-tag acc)))
          ""
          [doc]))

(defn my-hiccup [doc]
  (my-hiccup* doc))

;; (let [my-doc [:p "This paragraph is just an "
;;               [:a {:href "http://example.com"} "example"] "."]]
;;   (my-hiccup* my-doc))
(let [my-doc [:html
              [:head
               [:title "HTML output from vectors!"]]
              [:body
               [:h1 {:id "page-title"} "HTML output from vectors!"]
               [:div {:class "main-content"}
                [:p "converting nested lists into HTML is an old Lisp trick"]
                [:p "But Clojure uses vectors instead."]]]]]
  (my-hiccup my-doc))
