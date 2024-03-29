resource "aws_wafv2_web_acl" "default" {
  count = var.enabled ? 1 : 0

  name          = var.name
  description   = var.description
  scope         = var.scope
  token_domains = var.token_domains
  tags          = var.tags

  dynamic "default_action" {
    for_each = var.default_action
    content {
      dynamic "allow" {
        for_each = default_action.value.allow
        content {}
      }

      dynamic "block" {
        for_each = default_action.value.block
        content {}
      }
    }
  }

  dynamic "visibility_config" {
    for_each = var.visibility_config
    content {
      cloudwatch_metrics_enabled = visibility_config.value.cloudwatch_metrics_enabled
      metric_name                = visibility_config.value.metric_name
      sampled_requests_enabled   = visibility_config.value.sampled_requests_enabled
    }
  }

  dynamic "custom_response_body" {
    for_each = var.custom_response_body
    content {
      key          = custom_response_body.value.key
      content      = custom_response_body.value.content
      content_type = custom_response_body.value.content_type
    }
  }

  dynamic "rule" {
    for_each = var.rules
    content {
      name     = rule.value.name
      priority = rule.value.priority

      dynamic "action" {
        for_each = lookup(rule.value, "action", null) != null ? rule.value.action : []
        content {
          dynamic "allow" {
            for_each = action.value.allow
            content {
            }
          }
          dynamic "block" {
            for_each = action.value.block
            content {
            }
          }
          dynamic "count" {
            for_each = action.value.count
            content {
            }
          }
          dynamic "captcha" {
            for_each = action.value.captcha
            content {
            }
          }
          dynamic "challenge" {
            for_each = action.value.challenge
            content {
            }
          }
        }
      }

      dynamic "override_action" {
        for_each = lookup(rule.value, "override_action", null) != null ? rule.value.override_action : []
        content {
          dynamic "count" {
            for_each = override_action.value.count
            content {
            }
          }
          dynamic "none" {
            for_each = override_action.value.none
            content {
            }
          }
        }
      }

      dynamic "visibility_config" {
        for_each = lookup(rule.value, "visibility_config", null) != null ? rule.value.visibility_config : []

        content {
          cloudwatch_metrics_enabled = lookup(visibility_config.value, "cloudwatch_metrics_enabled", true)
          metric_name                = visibility_config.value.metric_name
          sampled_requests_enabled   = lookup(visibility_config.value, "sampled_requests_enabled", true)
        }
      }

      dynamic "captcha_config" {
        for_each = lookup(rule.value, "captcha_config", null) != null ? rule.value.captcha_config : []

        content {
          immunity_time_property {
            immunity_time = captcha_config.value.immunity_time_property.immunity_time
          }
        }
      }

      dynamic "rule_label" {
        for_each = lookup(rule.value, "rule_label", null) != null ? rule.value.rule_label : []
        content {
          name = rule_label.value
        }
      }

      dynamic "statement" {
        for_each = lookup(rule.value, "statement", null) != null ? rule.value.statement : []
        content {

          dynamic "regex_pattern_set_reference_statement" {
            for_each = lookup(statement.value, "regex_pattern_set_reference_statement", [])
            content {
              arn = regex_pattern_set_reference_statement.value.arn
              field_to_match {
                dynamic "uri_path" {
                  for_each = lookup(regex_pattern_set_reference_statement.value.field_to_match[0], "uri_path", [])
                  content {}
                }
                dynamic "single_header" {
                  for_each = lookup(regex_pattern_set_reference_statement.value.field_to_match[0], "single_header", [])
                  content {
                    name = regex_pattern_set_reference_statement.value.field_to_match[0].single_header[0].name
                  }
                }

              }
              text_transformation {
                priority = regex_pattern_set_reference_statement.value.text_transformation[0].priority
                type     = regex_pattern_set_reference_statement.value.text_transformation[0].type
              }
            }
          }

          dynamic "rule_group_reference_statement" {
            for_each = lookup(statement.value, "rule_group_reference_statement", [])
            content {
              arn = rule_group_reference_statement.value.arn
            }
          }

          dynamic "and_statement" {
            for_each = lookup(statement.value, "and_statement", null) != null ? statement.value.and_statement : []
            content {
              dynamic "statement" {
                for_each = lookup(and_statement.value, "statement", null) != null ? and_statement.value.statement : []
                content {

                  dynamic "size_constraint_statement" {
                    for_each = lookup(statement.value, "size_constraint_statement", [])
                    content {
                      comparison_operator = size_constraint_statement.value.comparison_operator
                      field_to_match {
                        dynamic "uri_path" {
                          for_each = lookup(size_constraint_statement.value.field_to_match[0], "uri_path", [])
                          content {}
                        }
                        dynamic "single_header" {
                          for_each = lookup(size_constraint_statement.value.field_to_match[0], "single_header", [])
                          content {
                            name = size_constraint_statement.value.field_to_match[0].single_header[0].name
                          }
                        }

                      }
                      size = size_constraint_statement.value.size
                      text_transformation {
                        priority = size_constraint_statement.value.text_transformation[0].priority
                        type     = size_constraint_statement.value.text_transformation[0].type
                      }
                    }
                  }

                  dynamic "byte_match_statement" {
                    for_each = lookup(statement.value, "byte_match_statement", []) != [] ? statement.value.byte_match_statement : []
                    content {
                      positional_constraint = byte_match_statement.value.positional_constraint
                      search_string         = byte_match_statement.value.search_string
                      field_to_match {
                        dynamic "uri_path" {
                          for_each = lookup(byte_match_statement.value.field_to_match[0], "uri_path", [])
                          content {}
                        }
                        dynamic "single_header" {
                          for_each = lookup(byte_match_statement.value.field_to_match[0], "single_header", [])
                          content {
                            name = byte_match_statement.value.field_to_match[0].single_header[0].name
                          }
                        }
                      }
                      text_transformation {
                        priority = byte_match_statement.value.text_transformation[0].priority
                        type     = byte_match_statement.value.text_transformation[0].type
                      }
                    }
                  }

                  dynamic "not_statement" {
                    for_each = lookup(statement.value, "not_statement", null) != null ? statement.value.not_statement : []
                    content {
                      statement {
                        dynamic "byte_match_statement" {
                          for_each = lookup(not_statement.value.statement[0], "byte_match_statement", null) != null ? not_statement.value.statement[0].byte_match_statement : []
                          content {
                            positional_constraint = lookup(byte_match_statement.value, "positional_constraint", null)
                            search_string         = byte_match_statement.value.search_string
                            dynamic "field_to_match" {
                              for_each = lookup(byte_match_statement.value, "field_to_match", null) != null ? byte_match_statement.value.field_to_match : []
                              content {
                                dynamic "uri_path" {
                                  for_each = lookup(field_to_match.value, "uri_path", null) != null ? [1] : []
                                  content {}
                                }
                              }
                            }
                            dynamic "text_transformation" {
                              for_each = lookup(byte_match_statement.value, "text_transformation", null) != null ? byte_match_statement.value.text_transformation : []
                              content {
                                priority = text_transformation.value.priority
                                type     = text_transformation.value.type
                              }
                            }
                          }
                        }
                      }
                    }
                  }

                }
              }
            }
          }

          dynamic "managed_rule_group_statement" {
            for_each = lookup(statement.value, "managed_rule_group_statement", null) != null ? statement.value.managed_rule_group_statement : []

            content {
              name        = managed_rule_group_statement.value.name
              vendor_name = managed_rule_group_statement.value.vendor_name
              version     = lookup(managed_rule_group_statement.value, "version", "") != "" ? managed_rule_group_statement.value.version : null


              dynamic "scope_down_statement" {
                for_each = lookup(managed_rule_group_statement.value, "scope_down_statement", null) != null ? managed_rule_group_statement.value.scope_down_statement : []

                content {
                  dynamic "byte_match_statement" {
                    for_each = lookup(scope_down_statement.value, "byte_match_statement", null) != null ? scope_down_statement.value.byte_match_statement : []

                    content {
                      positional_constraint = lookup(byte_match_statement.value, "positional_constraint", null)
                      search_string         = byte_match_statement.value.search_string
                      dynamic "field_to_match" {
                        for_each = lookup(byte_match_statement.value, "field_to_match", null) != null ? byte_match_statement.value.field_to_match : []
                        content {
                          dynamic "uri_path" {
                            for_each = lookup(field_to_match.value, "uri_path", null) != null ? [1] : []
                            content {}
                          }
                        }
                      }
                      dynamic "text_transformation" {
                        for_each = lookup(byte_match_statement.value, "text_transformation", null) != null ? byte_match_statement.value.text_transformation : []
                        content {
                          priority = text_transformation.value.priority
                          type     = text_transformation.value.type
                        }
                      }
                    }
                  }

                  dynamic "and_statement" {
                    for_each = lookup(scope_down_statement.value, "and_statement", null) != null ? scope_down_statement.value.and_statement : []
                    content {
                      dynamic "statement" {
                        for_each = lookup(and_statement.value, "statement", null) != null ? and_statement.value.statement : []
                        content {
                          dynamic "not_statement" {
                            for_each = lookup(statement.value, "not_statement", null) != null ? statement.value.not_statement : []
                            content {
                              statement {
                                dynamic "byte_match_statement" {
                                  for_each = lookup(not_statement.value.statement[0], "byte_match_statement", null) != null ? not_statement.value.statement[0].byte_match_statement : []
                                  content {
                                    positional_constraint = lookup(byte_match_statement.value, "positional_constraint", null)
                                    search_string         = byte_match_statement.value.search_string
                                    dynamic "field_to_match" {
                                      for_each = lookup(byte_match_statement.value, "field_to_match", null) != null ? byte_match_statement.value.field_to_match : []
                                      content {
                                        dynamic "uri_path" {
                                          for_each = lookup(field_to_match.value, "uri_path", null) != null ? [1] : []
                                          content {}
                                        }
                                      }
                                    }
                                    dynamic "text_transformation" {
                                      for_each = lookup(byte_match_statement.value, "text_transformation", null) != null ? byte_match_statement.value.text_transformation : []
                                      content {
                                        priority = text_transformation.value.priority
                                        type     = text_transformation.value.type
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }

              dynamic "rule_action_override" {
                for_each = lookup(managed_rule_group_statement.value, "rule_action_override", null) != null ? managed_rule_group_statement.value.rule_action_override : []
                content {
                  name = rule_action_override.value.name
                  dynamic "action_to_use" {
                    for_each = lookup(rule_action_override.value, "action_to_use", null) != null ? rule_action_override.value.action_to_use : []
                    content {

                      dynamic "allow" {
                        for_each = action_to_use.value.allow
                        content {
                          dynamic "custom_request_handling" {
                            for_each = allow.value.custom_request_handling
                            content {
                              insert_header {
                                name  = custom_request_handling.value[0].insert_header.name
                                value = custom_request_handling.value[0].insert_header.value
                              }
                            }
                          }
                        }
                      }
                      dynamic "block" {
                        for_each = action_to_use.value.block
                        content {
                          dynamic "custom_response" {
                            for_each = block.value.custom_response
                            content {
                              response_code            = custom_response.value[0].response_code
                              custom_response_body_key = lookup(custom_response.value[0], "custom_response_body_key", null)
                              dynamic "response_header" {
                                for_each = lookup(custom_response.value[0], "response_header", null) != null ? [1] : []
                                content {
                                  name  = custom_response.value[0].response_header.name
                                  value = custom_response.value[0].response_header.value
                                }
                              }
                            }
                          }
                        }
                      }
                      dynamic "count" {
                        for_each = action_to_use.value.count
                        content {
                          dynamic "custom_request_handling" {
                            for_each = count.value.custom_request_handling
                            content {
                              insert_header {
                                name  = custom_request_handling.value[0].insert_header.name
                                value = custom_request_handling.value[0].insert_header.value
                              }
                            }
                          }
                        }
                      }
                      dynamic "captcha" {
                        for_each = action_to_use.value.captcha
                        content {
                          dynamic "custom_request_handling" {
                            for_each = captcha.value.custom_request_handling
                            content {
                              insert_header {
                                name  = custom_request_handling.value[0].insert_header.name
                                value = custom_request_handling.value[0].insert_header.value
                              }
                            }
                          }
                        }
                      }
                      dynamic "challenge" {
                        for_each = action_to_use.value.challenge
                        content {
                          dynamic "custom_request_handling" {
                            for_each = challenge.value.custom_request_handling
                            content {
                              insert_header {
                                name  = custom_request_handling.value[0].insert_header.name
                                value = custom_request_handling.value[0].insert_header.value
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
