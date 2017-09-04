# Database Design

## Table: pipeline\_groups
| Field name | Data type | Extra
| --- | --- | ---
| id | integer | `primary_key`
| name | string | `NOT NULL`
| inserted\_at | datetime |
| updated\_at | datetime |

## Table: pipelines
| Field name | Data type | Extra
| --- | --- | ---
| id | integer | `primary_key`
| name | string | `NOT NULL`
| pipeline\_group\_id | belongs\_to | `NOT NULL`
| inserted\_at | datetime |
| updated\_at | datetime |

## Table: pipelines\_materials
| Field name | Data type | Extra
| --- | --- | ---
| pipeline\_id | integer | `compound_key`
| material\_id | integer | `compound_key`

## Table: materials
| Field name | Data type | Extra
| --- | --- | ---
| id | integer | `primary_key`
| type | string | `enum: {git|file|...}`
| url | string | `{git://...|file://source_pipeline/release.tar.gz}`
| inserted\_at | datetime |
| updated\_at | datetime |

## Table: environment\_variables
| Field name | Data type | Extra
| --- | --- | ---
| id | integer | `primary_key`
| name | string
| value | text
| inserted\_at | datetime |
| updated\_at | datetime |

## Table: pipelines\_environment\_variables
| Field name | Data type | Extra
| --- | --- | ---
| pipeline\_id | integer | `compound_key`
| environment\_variable\_id | integer | `compound_key`
