import '../models/marketplace_item.dart';

const marketplaceCategories = <String>[
  '전체',
  '패션',
  '디지털',
  '라이프',
  '빈티지',
  '뷰티',
];

const demoMarketplaceItems = <MarketplaceItem>[
  MarketplaceItem(
    id: 'paris-leather-tote',
    title: '파리 빈티지 레더 토트',
    price: 279000,
    category: '패션',
    location: 'Paris · Le Marais',
    timeAgo: '18분 전',
    likes: 42,
    imageUrl:
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=1000&q=85',
    description:
        '르 마레의 작은 빈티지 숍에서 직접 고른 레더 토트입니다. 자연스러운 사용감이 있고 내부 컨디션은 깨끗합니다. 파리 현지 픽업 또는 다음 서울 이동 일정에 맞춰 전달할 수 있어요.',
    sellerName: 'Sarah Kim',
    sellerLocation: '파리 체류 · 4년',
    sellerRating: 4.9,
    sellerDeals: 32,
    tags: ['현지 검수', '직접 픽업', '안전거래'],
    isFeatured: true,
  ),
  MarketplaceItem(
    id: 'tokyo-headphones',
    title: '도쿄 한정 무선 헤드폰',
    price: 158000,
    category: '디지털',
    location: 'Tokyo · Shibuya',
    timeAgo: '32분 전',
    likes: 27,
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=1000&q=85',
    description:
        '시부야 매장에서 구매한 한정 컬러 헤드폰입니다. 박스와 구성품을 모두 보관하고 있으며 짧게 테스트만 진행했습니다.',
    sellerName: 'Mina Park',
    sellerLocation: '도쿄 체류 · 2년',
    sellerRating: 4.8,
    sellerDeals: 18,
    tags: ['풀박스', '동작 확인', '직거래 가능'],
    isFeatured: true,
  ),
  MarketplaceItem(
    id: 'seongsu-camera',
    title: '성수 필름 카메라 + 35mm 렌즈',
    price: 420000,
    category: '빈티지',
    location: 'Seoul · Seongsu',
    timeAgo: '1시간 전',
    likes: 61,
    imageUrl:
        'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?auto=format&fit=crop&w=1000&q=85',
    description:
        '여행 기록용으로 사용한 필름 카메라입니다. 노출계와 셔터 모두 정상이며 최근 전문점에서 점검했습니다. 테스트 필름 결과도 채팅으로 보내드릴게요.',
    sellerName: 'Joon Lee',
    sellerLocation: '서울 · 성수동',
    sellerRating: 5.0,
    sellerDeals: 45,
    tags: ['점검 완료', '직거래 추천', '샘플 사진'],
    isFeatured: true,
  ),
  MarketplaceItem(
    id: 'milan-sneakers',
    title: '밀라노 러너 스니커즈 270',
    price: 189000,
    category: '패션',
    location: 'Milano · Brera',
    timeAgo: '2시간 전',
    likes: 19,
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=1000&q=85',
    description:
        '브레라 편집숍에서 구매한 러너 스니커즈입니다. 실착 2회, 밑창 마모 거의 없습니다. 여행 중 부피 때문에 정리합니다.',
    sellerName: 'Luca Han',
    sellerLocation: '밀라노 체류 · 1년',
    sellerRating: 4.7,
    sellerDeals: 12,
    tags: ['실착 2회', '현지 구매', '박스 포함'],
  ),
  MarketplaceItem(
    id: 'jeju-ceramic',
    title: '제주 스튜디오 핸드메이드 머그',
    price: 32000,
    category: '라이프',
    location: 'Jeju · Aewol',
    timeAgo: '3시간 전',
    likes: 35,
    imageUrl:
        'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?auto=format&fit=crop&w=1000&q=85',
    description:
        '애월 작업실에서 직접 구매한 손잡이 머그입니다. 유약 흐름이 한 점씩 달라 같은 제품이 없는 소량 제작품입니다.',
    sellerName: 'Hana Cho',
    sellerLocation: '제주 · 애월',
    sellerRating: 4.9,
    sellerDeals: 29,
    tags: ['소량 제작', '미사용', '파손 보장 포장'],
  ),
  MarketplaceItem(
    id: 'berlin-sunglasses',
    title: '베를린 아세테이트 선글라스',
    price: 87000,
    category: '패션',
    location: 'Berlin · Mitte',
    timeAgo: '5시간 전',
    likes: 14,
    imageUrl:
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&w=1000&q=85',
    description:
        '미테의 독립 아이웨어 숍에서 구입했습니다. 가볍고 얼굴에 편하게 맞는 프레임이며 케이스와 클리너가 포함됩니다.',
    sellerName: 'Eun Seo',
    sellerLocation: '베를린 체류 · 3년',
    sellerRating: 4.8,
    sellerDeals: 21,
    tags: ['케이스 포함', '현지 브랜드', '상태 최상'],
  ),
];
