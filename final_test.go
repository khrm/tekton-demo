// Copyright 2010 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package main

import (
	"testing"
)

func TestPage_save(t *testing.T) {
	type fields struct {
		Title string
		Body  []byte
	}
	tests := []struct {
		name    string
		fields  fields
		wantErr bool
	}{
		{
			name: "Simple Unit Test for Saving Page",
			fields: fields{
				Title: "UnitTest1",
				Body:  []byte("UnitTest1"),
			},
			wantErr: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			p := &Page{
				Title: tt.fields.Title,
				Body:  tt.fields.Body,
			}
			if err := p.save(); (err != nil) != tt.wantErr {
				t.Errorf("Page.save() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}
