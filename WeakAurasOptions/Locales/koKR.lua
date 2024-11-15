if not(GetLocale() == "koKR") then
  return
end

local L = WeakAuras.L

-- WeakAuras/Options
	L["-- Do not remove this comment, it is part of this trigger: "] = "-- 이 주석을 삭제하지 마세요, 이 활성 조건의 일부입니다: "
	L["% of Progress"] = "진행 상태의 %"
	L["%i Matches"] = "%i개 일치"
	--[[Translation missing --]]
	L["%s Color"] = "%s Color"
	--[[Translation missing --]]
	L["%s total auras"] = "%s total auras"
	L["1 Match"] = "1개 일치"
	L["1. Text"] = "1. 문자"
	L["1. Text Settings"] = "1. 문자 설정"
	L["2. Text"] = "2. 문자"
	L["2. Text Settings"] = "2. 문자 설정"
	L["A 20x20 pixels icon"] = "20x20 픽셀 아이콘"
	L["A 32x32 pixels icon"] = "32x32 픽셀 아이콘"
	L["A 40x40 pixels icon"] = "40x40 픽셀 아이콘"
	L["A 48x48 pixels icon"] = "48x48 픽셀 아이콘"
	L["A 64x64 pixels icon"] = "64x64 픽셀 아이콘"
	L["A group that dynamically controls the positioning of its children"] = "포함된 개체들의 배열을 유동적으로 조절하는 그룹"
	L["Actions"] = "동작"
	L["Add a new display"] = "새로운 디스플레이 추가"
	L["Add Condition"] = "조건 추가"
	--[[Translation missing --]]
	L["Add Overlay"] = "Add Overlay"
	L["Add Property Change"] = "속성 변경 추가"
	L["Add to group %s"] = "그룹 %s에 추가"
	L["Add to new Dynamic Group"] = "새 유동적 그룹에 추가"
	L["Add to new Group"] = "새 그룹에 추가"
	L["Add Trigger"] = "활성 조건 추가"
	L["Addon"] = "애드온"
	L["Addons"] = "애드온"
	L["Align"] = "정렬"
	L["Allow Full Rotation"] = "전체 회전 허용"
	L["Alpha"] = "투명도"
	L["Anchor"] = "고정시키기"
	L["Anchor Point"] = "고정 지점"
	L["Anchored To"] = "다음에 고정:"
	--[[Translation missing --]]
	L["And "] = "And "
	L["Angle"] = "각도"
	L["Animate"] = "애니메이션"
	L["Animated Expand and Collapse"] = "확장 / 접기 애니메이션"
	--[[Translation missing --]]
	L["Animates progress changes"] = "Animates progress changes"
	L["Animation relative duration description"] = [=[
디스플레이 지속시간의 비율로 애니메이션 지속시간을 설정합니다, 분수 (1/2), 백분율 (50%), 또는 소수 (0.5)로 표현합니다.
|cFFFF0000참고:|r 디스플레이가 진행 시간이 없으면 (비-지속적 이벤트 활성 조건, 지속시간이 없는 오라, 등등), 애니메이션은 재생되지 않습니다.

|cFF4444FF예제:|r
애니메이션의 지속시간을 |cFF00CC0010%|r로 설정하고, 디스플레이의 활성 조건이 20초 지속 강화 효과일 때, 시작 애니메이션은 2초 동안 재생됩니다.
애니메이션의 지속시간을 |cFF00CC0010%|r로 설정하고, 디스플레이의 활성 조건이 지속시간이 없는 강화 효과일 때, 시작 애니메이션은 재생되지 않습니다 (지속시간을 따로 설정했더라도)."
]=]
	L["Animation Sequence"] = "애니메이션 순서"
	L["Animations"] = "애니메이션"
	L["Apply Template"] = "견본 적용"
	L["Arcane Orb"] = "비전 구슬"
	L["At a position a bit left of Left HUD position."] = "좌측 HUD 위치보다 약간 왼쪽에 위치시킵니다."
	L["At a position a bit left of Right HUD position"] = "우측 HUD 위치보다 약간 왼쪽에 위치시킵니다"
	L["At the same position as Blizzard's spell alert"] = "블리자드의 주문 경보와 같은 위치에 위치시킵니다"
	L["Aura Name"] = "효과 이름"
	L["Aura Type"] = "효과 유형"
	L["Aura(s)"] = "효과"
	L["Aura:"] = "효과:"
	L["Auras:"] = "효과들:"
	L["Auto"] = "자동"
	L["Auto-cloning enabled"] = "자동 복제 활성화"
	L["Automatic Icon"] = "자동 아이콘"
	L["Backdrop Color"] = "배경 색상"
	--[[Translation missing --]]
	L["Backdrop in Front"] = "Backdrop in Front"
	L["Backdrop Style"] = "배경 스타일"
	L["Background"] = "배경"
	L["Background Color"] = "배경 색상"
	L["Background Inset"] = "배경 축소"
	L["Background Offset"] = "배경 위치"
	L["Background Texture"] = "배경 텍스쳐"
	L["Bar Alpha"] = "바 투명도"
	L["Bar Color"] = "바 색상"
	L["Bar Color Settings"] = "바 색상 설정"
	L["Bar Texture"] = "바 텍스쳐"
	L["Big Icon"] = "큰 아이콘"
	L["Blend Mode"] = "혼합 모드"
	L["Blue Rune"] = "푸른색 룬"
	L["Blue Sparkle Orb"] = "푸른 불꽃 구슬"
	L["Border"] = "테두리"
	L["Border Color"] = "테두리 색상"
	--[[Translation missing --]]
	L["Border in Front"] = "Border in Front"
	L["Border Inset"] = "테두리 삽입"
	L["Border Offset"] = "테두리 위치"
	L["Border Settings"] = "테두리 설정"
	L["Border Size"] = "테두리 크기"
	L["Border Style"] = "테두리 모양"
	L["Bottom Text"] = "하단 문자"
	L["Bracket Matching"] = "괄호 맞춤"
	L["Button Glow"] = "버튼 반짝임"
	L["Can be a name or a UID (e.g., party1). A name only works on friendly players in your group."] = "이름 또는 UID (예. party1)를 사용할 수 있습니다. 이름은 같은 파티에 속해 있는 우호적 플레이어에게만 작동합니다."
	L["Cancel"] = "취소"
	L["Channel Number"] = "채널 번호"
	L["Chat Message"] = "대화 메시지"
	L["Check On..."] = "확인..."
	L["Children:"] = "자식:"
	L["Choose"] = "선택"
	L["Choose Trigger"] = "활성 조건 선택"
	L["Choose whether the displayed icon is automatic or defined manually"] = "아이콘을 자동으로 표시할 지 또는 수동 지정할 지 선택하세요"
	L["Clone option enabled dialog"] = [=[
|cFFFF0000자동복제|r 옵션을 활성화 했습니다.

|cFFFF0000자동복제|r는 디스플레이를 자동으로 복사하여 여러 정보를 표시하게 합니다.
이 디스플레이를 |cFF22AA22유동적 그룹|r에 넣을 때까지, 복제된 모든 디스플레이가 표시됩니다.

이 디스플레이를 새로운 |cFF22AA22유동적 그룹|r으로 옮길까요?]=]
	L["Close"] = "닫기"
	L["Collapse"] = "접기"
	L["Collapse all loaded displays"] = "불러온 모든 디스플레이 접기"
	L["Collapse all non-loaded displays"] = "불러오지 않은 모든 디스플레이 접기"
	L["Color"] = "색상"
	--[[Translation missing --]]
	L["color"] = "color"
	--[[Translation missing --]]
	L["Common Options"] = "Common Options"
	L["Compress"] = "누르기"
	--[[Translation missing --]]
	L["Condition %i"] = "Condition %i"
	L["Conditions"] = "조건"
	L["Constant Factor"] = "고정 요소"
	L["Control-click to select multiple displays"] = "Ctrl+클릭하여 여러 디스플레이 선택"
	L["Controls the positioning and configuration of multiple displays at the same time"] = "동시에 여러 디스플레이의 위치와 설정을 조절합니다"
	L["Convert to..."] = "변환하기..."
	L["Cooldown"] = "재사용 대기시간"
	L["Copy settings..."] = "설정 복사..."
	--[[Translation missing --]]
	L["Copy to all auras"] = "Copy to all auras"
	L["Copy URL"] = "URL 복사"
	L["Count"] = "횟수"
	L["Creating buttons: "] = "버튼 생성:"
	L["Creating options: "] = "옵션 생성:"
	L["Crop"] = "자르기"
	L["Crop X"] = "X 자르기"
	L["Crop Y"] = "Y 자르기"
	L["Custom"] = "사용자 설정"
	L["Custom Code"] = "사용자 정의 코드"
	L["Custom Function"] = "사용자 설정 함수"
	L["Custom Trigger"] = "사용자 설정 활성 조건"
	L["Custom trigger event tooltip"] = [=[
사용자 설정 활성 조건을 확인할 이벤트를 선택하세요.
콤마와 공백을 사용해 여러 이벤트를 선택할 수 있습니다.

|cFF4444FF예제:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom trigger status tooltip"] = [=[
사용자 설정 활성 조건을 확인할 이벤트를 선택하세요.
상태 형식 조건이면 특정 이벤트는 독립 변수없이 WeakAuras에 의해 불러와집니다.
콤마와 공백을 사용해 여러 이벤트를 선택할 수 있습니다.

|cFF4444FF예제:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom Untrigger"] = "사용자 설정 비활성 조건"
	L["Debuff Type"] = "약화 효과 유형"
	L["Default"] = "기본"
	L["Delete"] = "삭제"
	L["Delete all"] = "모두 삭제"
	L["Delete children and group"] = "자식과 그룹 삭제"
	L["Delete Trigger"] = "활성 조건 삭제"
	L["Desaturate"] = "흑백"
	--[[Translation missing --]]
	L["Differences"] = "Differences"
	L["Disable Import"] = "가져오기 비활성화"
	L["Disabled"] = "비활성화됨"
	L["Discrete Rotation"] = "90도 단위 회전"
	L["Display"] = "디스플레이"
	L["Display Icon"] = "디스플레이 아이콘"
	L["Display Text"] = "디스플레이 문자"
	L["Displays a text, works best in combination with other displays"] = "문자를 표시합니다, 다른 디스플레이와 조합하여 사용하기 좋습니다"
	L["Distribute Horizontally"] = "가로로 퍼뜨리기"
	L["Distribute Vertically"] = "세로로 퍼뜨리기"
	L["Do not group this display"] = "이 디스플레이 그룹하지 않기"
	L["Done"] = "완료"
	--[[Translation missing --]]
	L["Down"] = "Down"
	L["Drag to move"] = "끌어서 이동"
	L["Duplicate"] = "복제"
	--[[Translation missing --]]
	L["Duplicate All"] = "Duplicate All"
	L["Duration (s)"] = "지속시간 (초)"
	L["Duration Info"] = "지속시간 정보"
	L["Dynamic Group"] = "유동적 그룹"
	L["Dynamic Information"] = "유동적 정보"
	L["Dynamic information from first active trigger"] = "첫번째 활성화된 활성 조건의 유동적 정보"
	L["Dynamic information from Trigger %i"] = "활성 조건 %i의 유동적 정보"
	L["Dynamic text tooltip"] = [=[이 문자를 유동적으로 만들 수 있는 특별 코드들입니다:

|cFFFF0000%p|r - 진행 - 타이머의 남은 시간, 또는 비-타이머 값
|cFFFF0000%t|r - 전체 - 타이머의 최대 지속시간, 또는 최대 비-타이머 값
|cFFFF0000%n|r - 이름 - 디스플레이의 이름 (보통 오라 이름), 또는 유동적 이름이 없을 때 디스플레이의 ID
|cFFFF0000%i|r - 아이콘 - 디스플레이와 연관된 아이콘
|cFFFF0000%s|r - 중첩 - 오라의 중첩 횟수 (보통)
|cFFFF0000%c|r - 사용자 설정 - 표시할 string 값을 반환하는 사용자 설정 Lua 함수 정의를 허용합니다]=]
	L["Enabled"] = "활성화됨"
	L["End Angle"] = "종료 각도"
	L["Enter an aura name, partial aura name, or spell id"] = "효과 이름 / 효과 이름의 일부 / 주문 ID를 입력하세요"
	L["Event"] = "이벤트"
	L["Event Type"] = "이벤트 유형"
	L["Event(s)"] = "이벤트"
	L["Everything"] = "모두"
	L["Expand"] = "확장"
	L["Expand all loaded displays"] = "불러온 모든 디스플레이 확장"
	L["Expand all non-loaded displays"] = "불러오지 않은 모드 디스플레이 확장"
	L["Expansion is disabled because this group has no children"] = "이 그룹에 자식이 없어 확장이 비활성되었습니다"
	L["Export to Lua table..."] = "Lua table로 내보내기..."
	L["Export to string..."] = "문자열로 내보내기..."
	L["Fade"] = "사라짐"
	L["Fade In"] = "서서히 나타남"
	L["Fade Out"] = "서서히 사라짐"
	--[[Translation missing --]]
	L["False"] = "False"
	L["Finish"] = "종료"
	L["Fire Orb"] = "화염 구슬"
	L["Font"] = "글꼴"
	L["Font Flags"] = "글꼴 효과"
	L["Font Size"] = "글꼴 크기"
	L["Font Type"] = "글꼴 종류"
	L["Foreground Color"] = "전경 색상"
	L["Foreground Texture"] = "전경 텍스쳐"
	L["Frame"] = "프레임"
	L["Frame Strata"] = "프레임 우선순위"
	L["From Template"] = "견본으로부터"
	L["Full Scan"] = "전체 검사"
	L["General Text Settings"] = "일반 문자 설정"
	L["Glow"] = "반짝이기"
	L["Glow Action"] = "반짝임 동작"
	L["Green Rune"] = "녹색 룬"
	L["Group"] = "그룹"
	L["Group (verb)"] = "그룹시키기"
	L["Group aura count description"] = [=[디스플레이 조건을 충족하기 위해 주어진 효과에 영향을 받는 한명 이상의 %s원의 숫자.
정수를 입력하면 (예. 5), 영향을 받는 공격대원의 숫자를 입력된 숫자와 비교합니다.
소수 (예. 0.5), 분수 (예. 1/2), 또는 백분율 (예. 50%%)을 입력하면, %s원 중 일부가 영향을 받아야 합니다.

|cFF4444FF예제:|r
|cFF00CC00> 0|r %s 중 아무나 영향 받을 때 발생
|cFF00CC00= 100%%|r %s 중 모두가 영향 받을 때 발생
|cFF00CC00!= 2|r 영향 받는 %s원의 숫자가 2가 아닐 때 발생
|cFF00CC00<= 0.8|r %s 중 80%% 이하가 영향 받을 때 발생 (5명 파티원중 4명, 10명 공격대원 중 8명 또는 25명 공격대원중 20명)
|cFF00CC00> 1/2|r %s의 절반 이상이 영향 받을 때 발생
|cFF00CC00>= 0|r 상관없이, 항상 발생]=]
	L["Group Member Count"] = "그룹원 수"
	L["Grow"] = "성장"
	L["Hawk"] = "매"
	L["Height"] = "높이"
	L["Hide"] = "숨기기"
	L["Hide on"] = "숨기기"
	L["Hide this group's children"] = "이 그룹의 자식 숨기기"
	L["Hide When Not In Group"] = "파티중이 아닐 때 숨기기"
	L["Horizontal Align"] = "가로 정렬"
	L["Horizontal Bar"] = "가로 바"
	L["Horizontal Blizzard Raid Bar"] = "수평 블리자드 공격대 바"
	L["Huge Icon"] = "거대한 아이콘"
	L["Hybrid Position"] = "복합 위치"
	L["Hybrid Sort Mode"] = "복합 정렬 모드"
	L["Icon"] = "아이콘"
	L["Icon Color"] = "아이콘 색상"
	L["Icon Info"] = "아이콘 정보"
	L["Icon Inset"] = "아이템 축소"
	--[[Translation missing --]]
	L["If"] = "If"
	L["If this option is enabled, you are no longer able to import auras."] = "이 옵션이 활성화된 상태에서는 외부 문자열에서 디스플레이를 가져올 수 없습니다."
	--[[Translation missing --]]
	L["If Trigger %s"] = "If Trigger %s"
	L["Ignored"] = "무시됨"
	L["Import"] = "가져오기"
	L["Import a display from an encoded string"] = "암호화된 문자열에서 디스플레이 가져오기"
	L["Inverse"] = "반대로"
	--[[Translation missing --]]
	L["Inverse Slant"] = "Inverse Slant"
	L["Justify"] = "정렬"
	--[[Translation missing --]]
	L["Keep Aspect Ratio"] = "Keep Aspect Ratio"
	L["Leaf"] = "잎"
	L["Left 2 HUD position"] = "좌측 2 HUD 위치"
	L["Left HUD position"] = "좌측 HUD 위치"
	L["Left Text"] = "왼쪽 문자"
	L["Load"] = "불러오기"
	L["Loaded"] = "불러옴"
	L["Loop"] = "반복"
	L["Low Mana"] = "마나 낮음"
	L["Main"] = "메인"
	L["Manage displays defined by Addons"] = "애드온에 의해 정의된 디스플레이 관리"
	L["Medium Icon"] = "보통 아이콘"
	L["Message"] = "메시지"
	L["Message Prefix"] = "메시지 접두사"
	L["Message Suffix"] = "메시지 접미사"
	L["Message Type"] = "메시지 유형"
	L["Message type:"] = "메시지 유형:"
	L["Mirror"] = "뒤집기"
	L["Model"] = "모델"
	L["Move Down"] = "아래로 이동"
	L["Move this display down in its group's order"] = "이 디스플레이를 그룹 내 순서에서 아래로 이동"
	L["Move this display up in its group's order"] = "이 디스플레이를 그룹 내 순서에서 위로 이동"
	L["Move Up"] = "위로 이동"
	L["Multiple Displays"] = "다중 디스플레이"
	L["Multiple Triggers"] = "다중 활성 조건"
	L["Multiselect ignored tooltip"] = [=[
|cFFFF0000무시|r - |cFF777777단일|r - |cFF777777다중|r
디스플레이를 불러오는 데 영향을 주지 않습니다]=]
	L["Multiselect multiple tooltip"] = [=[
|cFF777777무시|r - |cFF777777단일|r - |cFF00FF00다중|r
선택한 것중 하나라도 일치할 때 불러옵니다]=]
	L["Multiselect single tooltip"] = [=[
|cFF777777무시|r - |cFF00FF00단일|r - |cFF777777다중|r
선택한 한가지만 일치할 때 불러옴]=]
	L["Name Info"] = "이름 정보"
	L["Negator"] = "Not"
	L["Never"] = "절대 안함"
	L["New"] = "새로 만들기"
	L["No"] = "아니오"
	L["No Children"] = "자식 없음"
	L["No tooltip text"] = "툴팁 문자 없음"
	L["None"] = "없음"
	L["Not all children have the same value for this option"] = "모든 자식의 이 옵션 값이 같지 않습니다"
	L["Not Loaded"] = "불러오지 않음"
	L["Offer a guided way to create auras for your class"] = "자신의 직업을 위한 오라를 쉽게 만들 수 있는 방법을 제공합니다"
	L["Okay"] = "확인"
	L["On Hide"] = "숨겨질 때"
	L["On Init"] = "초기 실행 시"
	L["On Show"] = "표시될 때"
	L["Only match auras cast by people other than the player"] = "플레이어가 아닌 다른 사람이 시전한 효과와 일치할때만"
	L["Only match auras cast by the player"] = "플레이어가 시전한 효과와 일치할때만"
	L["Operator"] = "연산자"
	--[[Translation missing --]]
	L["Options will open after combat ends."] = "Options will open after combat ends."
	L["or"] = "혹은"
	L["Orange Rune"] = "오렌지색 룬"
	L["Orientation"] = "방향"
	L["Outline"] = "외곽선"
	--[[Translation missing --]]
	L["Overflow"] = "Overflow"
	--[[Translation missing --]]
	L["Overlay %s Info"] = "Overlay %s Info"
	--[[Translation missing --]]
	L["Overlays"] = "Overlays"
	L["Own Only"] = "내 것만"
	--[[Translation missing --]]
	L["Paste Action Settings"] = "Paste Action Settings"
	--[[Translation missing --]]
	L["Paste Animations Settings"] = "Paste Animations Settings"
	--[[Translation missing --]]
	L["Paste Condition Settings"] = "Paste Condition Settings"
	--[[Translation missing --]]
	L["Paste Display Settings"] = "Paste Display Settings"
	--[[Translation missing --]]
	L["Paste Group Settings"] = "Paste Group Settings"
	--[[Translation missing --]]
	L["Paste Load Settings"] = "Paste Load Settings"
	--[[Translation missing --]]
	L["Paste Settings"] = "Paste Settings"
	L["Paste text below"] = "아래 문자를 붙여 넣으세요"
	--[[Translation missing --]]
	L["Paste Trigger Settings"] = "Paste Trigger Settings"
	L["Play Sound"] = "소리 재생"
	L["Portrait Zoom"] = "초상화 확대"
	--[[Translation missing --]]
	L["Position Settings"] = "Position Settings"
	L["Preset"] = "프리셋"
	L["Prevents duration information from decreasing when an aura refreshes. May cause problems if used with multiple auras with different durations."] = "효과가 갱신 됐을 때 지속시간 정보가 감소하지 않게 방지합니다. 다른 지속시간을 가진 여러 효과들과 같이 사용하면 문제가 발생할 수 있습니다."
	L["Processed %i chars"] = "%i 문자 복사됨"
	L["Progress Bar"] = "진행 바"
	L["Progress Texture"] = "진행 텍스쳐"
	L["Purple Rune"] = "보라색 룬"
	L["Put this display in a group"] = "이 디스플레이를 그룹에 넣기"
	L["Radius"] = "반경"
	L["Re-center X"] = "내부 X 좌표"
	L["Re-center Y"] = "내부 Y 좌표"
	--[[Translation missing --]]
	L["Regions of type \"%s\" are not supported."] = "Regions of type \"%s\" are not supported."
	L["Remaining Time"] = "남은 시간"
	L["Remaining Time Precision"] = "남은 시간 정확도"
	--[[Translation missing --]]
	L["Remove"] = "Remove"
	L["Remove this condition"] = "이 조건 삭제"
	L["Remove this display from its group"] = "이 디스플레이를 그룹에서 제거하기"
	L["Remove this property"] = "이 속성 삭제"
	L["Rename"] = "이름 변경"
	L["Repeat After"] = "반복 횟수"
	--[[Translation missing --]]
	L["Repeat every"] = "Repeat every"
	L["Required for Activation"] = "활성화에 필요"
	L["Right 2 HUD position"] = "우측 2 HUD 위치"
	L["Right HUD position"] = "우측 HUD 위치"
	L["Right Text"] = "오른쪽 문자"
	L["Right-click for more options"] = "RightClick - 추가 옵션"
	L["Rotate"] = "회전"
	L["Rotate In"] = "시계방향 회전"
	L["Rotate Out"] = "반시계방향 회전"
	L["Rotate Text"] = "문자 회전"
	L["Rotation"] = "회전"
	L["Rotation Mode"] = "회전 모드"
	L["Same"] = "동일한"
	L["Scale"] = "크기 비율"
	L["Search"] = "검색"
	L["Select the auras you always want to be listed first"] = "목록에서 첫번째로 표시할 오라를 선택하세요"
	L["Send To"] = "보내기..."
	L["Set Parent to Anchor"] = "부모를 고정기로 설정"
	L["Set tooltip description"] = "툴팁 설명 설정"
	L["Settings"] = "설정"
	L["Shift-click to create chat link"] = "Shift-클릭하여 대화 링크 만들기"
	L["Show all matches (Auto-clone)"] = "모든 일치 표시 (자동 복제)"
	L["Show Cooldown Text"] = "재사용 대기시간 문자 표시"
	--[[Translation missing --]]
	L["Show If Unit Is Invalid"] = "Show If Unit Is Invalid"
	L["Show model of unit "] = "유닛의 모델 표시"
	--[[Translation missing --]]
	L["Show On"] = "Show On"
	L["Show this group's children"] = "이 그룹의 자식 표시"
	L["Shows a 3D model from the game files"] = "게임 데이터의 3D 모델을 표시합니다"
	L["Shows a custom texture"] = "사용자 설정 텍스쳐 표시"
	L["Shows a progress bar with name, timer, and icon"] = "이름, 타이머, 아이콘과 함께 진행 바를 표시합니다"
	L["Shows a spell icon with an optional cooldown overlay"] = "재사용 대기시간 오버레이와 함께 주문 아이콘을 표시합니다"
	L["Shows a texture that changes based on duration"] = "지속시간에 따라 변화하는 텍스쳐를 표시합니다"
	L["Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "여러 줄의 문자를 표시합니다, 진행 시간 또는 중첩과 같은 여러 정보를 포함할 수 있습니다"
	L["Size"] = "크기"
	--[[Translation missing --]]
	L["Slant Amount"] = "Slant Amount"
	--[[Translation missing --]]
	L["Slant Mode"] = "Slant Mode"
	--[[Translation missing --]]
	L["Slanted"] = "Slanted"
	L["Slide"] = "슬라이드"
	L["Slide In"] = "안으로 슬라이드"
	L["Slide Out"] = "바깥으로 슬라이드"
	L["Small Icon"] = "작은 아이콘"
	--[[Translation missing --]]
	L["Smooth Progress"] = "Smooth Progress"
	L["Sort"] = "정렬"
	L["Sound"] = "소리"
	L["Sound Channel"] = "소리 채널"
	L["Sound File Path"] = "소리 파일 경로"
	L["Sound Kit ID"] = "Sound Kit ID"
	L["Space"] = "공간"
	L["Space Horizontally"] = "수평 공간"
	L["Space Vertically"] = "수직 공간"
	L["Spark"] = "섬광"
	L["Spark Settings"] = "섬광 설정"
	L["Spark Texture"] = "섬광 텍스쳐"
	L["Specific Unit"] = "특정 유닛"
	L["Spell ID"] = "주문 ID"
	L["Stack Count"] = "중첩 횟수"
	L["Stack Info"] = "중첩 정보"
	L["Stacks"] = "중첩"
	L["Stacks Settings"] = "중첩 설정"
	L["Stagger"] = "계단식 배치"
	L["Star"] = "별"
	L["Start"] = "시작"
	L["Start Angle"] = "시작 각도"
	L["Status"] = "상태"
	L["Stealable"] = "훔치기 가능"
	L["Sticky Duration"] = "지속시간 고정"
	L["Stop Sound"] = "소리 중지"
	L["Symbol Settings"] = "기호 설정"
	L["Temporary Group"] = "임시 그룹"
	L["Text"] = "문자"
	L["Text Color"] = "문자 색상"
	L["Text Position"] = "문자 위치"
	L["Texture"] = "텍스쳐"
	L["Texture Info"] = "텍스쳐 정보"
	--[[Translation missing --]]
	L["Texture Wrap"] = "Texture Wrap"
	L["The duration of the animation in seconds."] = "애니메이션 지속시간 (초)"
	--[[Translation missing --]]
	L["The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."] = "The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."
	L["The type of trigger"] = "활성 조건의 유형"
	--[[Translation missing --]]
	L["Then "] = "Then "
	L["This display is currently loaded"] = "이 디스플레이는 불러온 상태입니다"
	L["This display is not currently loaded"] = "이 디스플레이는 불러오지 않았습니다"
	L["This region of type \"%s\" is not supported."] = "이 영역은 \"%s\" 유형을 지원하지 않습니다."
	L["Time in"] = "시간 단위"
	L["Tiny Icon"] = "더 작은 아이콘"
	L["To Frame's"] = "프레임의 다음 지점:"
	L["to group's"] = "그룹 기준"
	L["To Personal Ressource Display's"] = "개인 자원 표시의 다음 지점:"
	L["To Screen's"] = "화면의 다음 지점:"
	L["Toggle the visibility of all loaded displays"] = "불러온 모든 디스플레이 표시 전환"
	L["Toggle the visibility of all non-loaded displays"] = "불러오지 않은 모든 디스플레이 표시 토글"
	L["Toggle the visibility of this display"] = "이 디스플레이의 표시 전환"
	L["Tooltip"] = "툴팁"
	L["Tooltip on Mouseover"] = "마우스오버 툴팁"
	L["Top HUD position"] = "상단 HUD 위치"
	L["Top Text"] = "상단 문자"
	L["Total Time Precision"] = "전체 시간 정확도"
	L["Trigger"] = "활성 조건"
	L["Trigger %d"] = "%d 활성 조건"
	L["Trigger:"] = "활성 조건:"
	--[[Translation missing --]]
	L["True"] = "True"
	L["Type"] = "유형"
	L["Undefined"] = "정의되지 않음"
	L["Ungroup"] = "그룹 해제"
	L["Unit"] = "유닛"
	L["Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "시작 또는 종료 애니메이션과 달리 메인 애니메이션은 디스플레이가 숨겨질 때까지 계속 반복됩니다."
	--[[Translation missing --]]
	L["Up"] = "Up"
	L["Update Custom Text On..."] = "사용자 설정 문자 갱신 중..."
	L["Use Full Scan (High CPU)"] = "전체 스캔 사용 (높은 CPU 사용률)"
	L["Use SetTransform (will change behaviour in 7.3)"] = "SetTransform 사용 (7.3에서 작동 변경)"
	L["Use tooltip \"size\" instead of stacks"] = "중첩 대신 툴팁 \"크기\" 사용"
	--[[Translation missing --]]
	L["Used in auras:"] = "Used in auras:"
	--[[Translation missing --]]
	L["Version: "] = "Version: "
	L["Vertical Align"] = "수직 정렬"
	L["Vertical Bar"] = "수직 바"
	L["View"] = "보기"
	L["Width"] = "너비"
	L["X Offset"] = "X 좌표"
	L["X Rotation"] = "X 회전"
	L["X Scale"] = "가로 크기"
	L["Y Offset"] = "Y 좌표"
	L["Y Rotation"] = "Y 회전"
	L["Y Scale"] = "세로 크기"
	L["Yellow Rune"] = "노란색 룬"
	L["Yes"] = "네"
	L["Z Offset"] = "Z 좌표"
	L["Z Rotation"] = "Z 회전"
	L["Zoom"] = "확대"
	L["Zoom In"] = "확대"
	L["Zoom Out"] = "축소"

