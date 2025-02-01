package tree_sitter_jj_template_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_jj_template "www.github.com/reo101/tree-sitter-jj_template/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_jj_template.Language())
	if language == nil {
		t.Errorf("Error loading JjTemplate grammar")
	}
}
