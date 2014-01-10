\version "2.14.2"

#(set-default-paper-size "letter" 'landscape)
#(set-global-staff-size 20)

\header {
title = \markup { \smallCaps { "hob. xv:27, iii, mm. 1-8" } }
subtitle = \markup { \smallCaps { "with thoroughbass reduction" } }
	poet = ""
	composer = \markup { \smallCaps { "haydn" } }
	tagline = ""
	copyright = ""
	}

	\paper {
		myStaffSize = #20
		#(define fonts
	   (make-pango-font-tree  "Fanwood"
	                          "Nimbus Sans"
	                          "Luxi Mono"
	;;                        "Helvetica"
	;;                        "Courier"
	     (/ myStaffSize 20)))
	
	 	indent = 0.0\in
		top-margin = 0.5\in
		bottom-margin = 0.25\in
		line-width = 9.0\in
		ragged-right = ##f
		ragged-bottom = ##t
		ragged-last-bottom = ##t
		system-system-spacing #'minimum-distance = #25
		markup-system-spacing #'minimum-distance = #20
		score-system-spacing #'minimum-distance = #25
		last-bottom-spacing #'minimum-distance = #15
		%	page-count = #3
		print-page-number = ##f
	
	}

global = { 
	\override Score.PaperColumn #'keep-inside-line = ##t 	
	\override Staff.TimeSignature #'style = #'() 
	\override Staff.KeyCancellation #'break-visibility = #all-invisible
	\override Staff.TimeSignature #'break-visibility = #end-of-line-invisible
	\set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
	\set Staff.explicitClefVisibility = #end-of-line-invisible	
	\override Score.RehearsalMark #'self-alignment-X = #LEFT
	\override Score.RehearsalMark #'Y-offset = #6
	\override Score.RehearsalMark #'font-size = #2

	% enter key signature, time signature, pickup length here
	\key c \major
	\time 2/4
	\partial 8
	}

upper = \relative c'' {
    \clef treble
	c16(\p d
	c8-.) g'16( a g8-.) c16( d
	c8-.) e-. r d16( c
	b a g f e d e c)
	b8-. d-. r c16( d
	c8-.) g'16( a g8-.) c16( d
	c8-.) e-. r d16( c
	b a g f e d c b) c8-. c-. r4
	}

lower = \relative c' {
    \clef bass
	r8
	<c e>8-. r <b d>-. r
	<a c>-. <e g>-. r4
	<f a>8-. r <fis a>-. r 
	<g b>-. <g b>-. r4
	<c e>8-. r <b d>-. r
	<a c>-. <e g>-. r4
	<f a>8-. r <g b>-. r 
	<c e>-. <c e>-. r4
	}


thoroughbass = <<
	\new Staff = bass <<
	
		\global
		\figuremode {
			\bassFigureStaffAlignmentUp
			\override BassFigure #'extra-offset = #'(0 . 1)
		
			% enter figures here within <> brackets
				% use + for sharp, - for flat, ! for natural
				% _ will make accidental by itself (apply to 3)
				% use s if bass note has no figure
				s8
				s4 <6> s8 <6>4. s4 <6 5> s2
				s4 <6> s8 <6>4. s4 s s2
			}

	\new Voice = "bass" <<
		\relative c' {
            \clef bass
            s8
			c4 b
			a8 e4.
			f4 fis 
			g2
			c4 b
			a8 e4.
			f4 g 
			c2
		}
		>>
	>>
	>>

functionalBass = {
	\set stanza = \markup { \normal-text "" }
		\lyricmode {
		
		% enter functional bass here, follwing the rules of lilypond lyrics
		
		}
	}

functionalBassLower = {
	\set stanza = \markup { \normal-text "" }
		\lyricmode {
	
		% enter functional bass here, follwing the rules of lilypond lyrics

		}
	}

roman = {
	\set stanza = \markup { \normal-text "" }
		\lyricmode {
		
		% enter functional bass here, follwing the rules of lilypond lyrics
		
	}
	}

\score {
<<
	
	\new PianoStaff \with { 
		\override StaffGrouper #'staff-staff-spacing #'minimum-distance = #10
		}
		<<
		\set PianoStaff.instrumentName = " "
		\set PianoStaff.shortInstrumentName = " "
		\set PianoStaff.midiInstrument = "piano" 
		\new Staff = "Staff_pfUpper" << \global \upper >>
		\new Staff = "Staff_pfUpper" << \global \lower >>
		>>
	<< \global \thoroughbass >>
%	\new Lyrics \lyricsto "bass" { \functionalBass }
%	\new Lyrics \lyricsto "bass" { \functionalBassLower }
%	\new Lyrics \lyricsto "bass" { \roman }
>>

	\layout { 
		\context { \Score \remove "Bar_number_engraver" }
%		\context { \Staff \remove "Time_signature_engraver" }
    }
	}
